//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Nurdana Rakhymova on 12/28/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var myDisplay: UILabel!
    
    var typing: Bool = false
    
    @IBAction func digitPressed(_ sender: UIButton) {
        let current_digit=sender.currentTitle!
        if typing {
            let current_display=myDisplay.text!
            myDisplay.text=current_display+current_digit
        }
        else {
            myDisplay.text=current_digit
            typing=true
        }
    
    }
    
    var displayValue: Double {
        get{
            return Double(myDisplay.text!)!
        }
        set{
            myDisplay.text=String(newValue)
        }
    }
    
    private var calculatorModel=CalculatorModel()
    @IBAction func operationPressed(_ sender: UIButton) {
        
        if (sender.currentTitle=="0"){
            typing=false
        }
        calculatorModel.setOperand(displayValue)
        calculatorModel.performOperation(sender.currentTitle!)
        displayValue=calculatorModel.getResult()!
        
        typing=false
    }
}

