//
//  ViewController.swift
//  Bitcoin Conversion App
//
//  Created by Sanjeev Bedasee on 12/10/18.
//  Copyright © 2018 Sanjeev Bedasee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    //API URL
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var currencySelected = ""
    var finalURL = ""
    var finalName = ""
    //Outlets documented
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //For the scrolling picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        currencySelected = currencySymbolArray[row]
        getBitcoinData(url: finalURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        nameLabel.text = "Hello, " + finalName + " Which Currency would you Like to Convert Too!"
    }
    //getting data from API
    func getBitcoinData(url: String){
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    print("We got Latest Data!")
                    let bitcoinJSON : JSON = JSON(response.result.value!)
                    self.updateBitcoinPrice(json: bitcoinJSON)
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Error"
                }
                
        }
    }
    //calling to update price.
    func updateBitcoinPrice(json: JSON) {
        if let bitcoinResult = json["ask"].double {
            bitcoinPriceLabel.text = currencySelected + String(bitcoinResult)
        } else {
            bitcoinPriceLabel.text = "Price Unavailable"
        }
        
    }

}

