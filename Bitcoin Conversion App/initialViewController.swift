//
//  initialViewController.swift
//  
//
//  Created by Sanjeev Bedasee on 12/12/18.
//

import UIKit

class initialViewController: UIViewController {
    //Variables and Outlets
    var nameText = ""

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func done(_ sender: Any) {
        self.nameText = textField.text!
        performSegue(withIdentifier: "name", sender: self)
    }
    //Preparing to transfer text to the other screen.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc  = segue.destination as! ViewController
        vc.finalName = self.nameText
    }

}
