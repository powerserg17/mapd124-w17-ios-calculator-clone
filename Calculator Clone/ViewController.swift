//
//  ViewController.swift
//  Calculator Clone
//  Serhii Pianykh 300907406
//
//  Copy of iOS native calculator with the same interface and functions.
//  Landscape functionality is not implemented
//  Design is adaptive for different screens
//
//  Created by Serhii Pianykh on 2017-01-17.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var display: UILabel!
    @IBOutlet var clearBtn: UIButton!
    
    //enumerate with operations list
    enum operation {
        case plus
        case minus
        case multiply
        case divide
        case result
    }
    //bool to know if it's a new entry
    var firstCharacter: Bool = true
    //first number of action, also hold subtotal results for previous operations
    var prevNumber: Double = 0
    //currently number being entered
    var currNumber: Double = 0
    //last posted operation
    var currOperation: operation? = nil
    //bool to know if the . was entered
    var dotted: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        print(sender.currentTitle!)
        
        //depending on which button pressed
        switch sender.currentTitle! {
            //numbers
            case "0"..."9":
                //if new number - display on title and change All Clear to Clear
                if firstCharacter == true {
                    display.text = sender.currentTitle!
                    firstCharacter = false
                    clearBtn.setTitle("C", for: .normal)
                } else { //otherwise - just append to existings decimals
                    display.text?.append(sender.currentTitle!)
                }
                currNumber = Double(display.text!)!
            
            //clear current number
            case "C":
                display.text="0"
                firstCharacter = true
                currNumber = 0
                clearBtn.setTitle("AC", for: .normal)
                dotted = false
            
            //clear all
            case "AC":
                display.text="0"
                firstCharacter = true
                currNumber = 0
                prevNumber = 0
                currOperation = nil
                dotted = false
            
            //add fractial part to number
            case ".":
                if firstCharacter {
                    display.text = "0."
                    firstCharacter = false
                } else if !dotted {
                    display.text?.append(".")
                    firstCharacter = false
                }
                dotted = true
            
            //change current number's sign
            case "±":
                if currNumber<0 {
                    display.text?.remove(at: (display.text?.startIndex)!)
                    currNumber = currNumber * (-1)
                } else if currNumber>0 {
                    display.text?.insert("-", at: (display.text?.startIndex)!)
                    currNumber = currNumber * (-1)
                } else if currNumber == 0 {
                    if prevNumber<0 {
                        display.text?.remove(at: (display.text?.startIndex)!)
                    } else if prevNumber>0 {
                        display.text?.insert("-", at: (display.text?.startIndex)!)
                    }
                    prevNumber = prevNumber * (-1)
                }
            
            //perform standart operations + - * /
            case "+":
                display.text = String(operationPressed(operation: .plus).clean)
            case "-":
                display.text = String(operationPressed(operation: .minus).clean)
            case "×":
                display.text = String(operationPressed(operation: .multiply).clean)
            case "÷":
                display.text = String(operationPressed(operation: .divide).clean)
            
            //percent operation
            //if we apply percent for current number
            case "%":
                if currNumber != 0 && prevNumber != 0 {
                    currNumber = prevNumber * 0.01 * currNumber
                } else if prevNumber == 0 {
                    currNumber = currNumber * 0.01
                } else { //or if we do it for existing subtotal/total result
                    currNumber = prevNumber * 0.01
                    currOperation = nil
                }
                
                display.text = String(currNumber.clean)
            
            //get a result
            case "=":
                display.text = String(operationPressed(operation: .result).clean)
                clearBtn.setTitle("AC", for: .normal)
            
            default: break
        }
    }
    
    //function takes pressed operation and if it's first operation - remembers it, if not - perfoming previous operation and remembers current
    func operationPressed(operation:operation)->Double {
        if currOperation == nil {
            currOperation = operation
            prevNumber = currNumber
            currNumber = 0
            dotted = false
            firstCharacter = true
        } else if currOperation == .result {
            currOperation = operation
            currNumber = 0
            dotted = false
            firstCharacter = true
        } else {
            prevNumber = performOperation()
            currOperation = operation
            currNumber = 0
            dotted = false
            firstCharacter = true
        }
        return prevNumber
    }
    
    //function performs main operations with two numbers
    func performOperation()->Double {
        switch currOperation! {
            case .plus:
                return prevNumber+currNumber
            case .minus:
                return prevNumber-currNumber
            case .multiply:
                return prevNumber*currNumber
            case .divide:
                return prevNumber/currNumber
            default: return 0
        }
    }

}

//extension for type Double, allows to remove fractial part of Double value if it's don't have any (integer)
extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

