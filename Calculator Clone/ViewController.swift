//
//  ViewController.swift
//  Calculator Clone
//
//  Created by Serhii Pianykh on 2017-01-17.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var display: UILabel!
    @IBOutlet var clearBtn: UIButton!
    
    enum operation {
        case plus
        case minus
        case multiply
        case divide
        case percent
        case point
        case revert
        case clear
        case result
    }
    
    var firstCharacter: Bool = true
    var prevNumber: Double = 0
    var currNumber: Double = 0
    var currOperation: operation? = nil
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
        
        switch sender.currentTitle! {
            case "0"..."9":
                if firstCharacter == true {
                    display.text = sender.currentTitle!
                    firstCharacter = false
                    clearBtn.setTitle("C", for: .normal)
                } else {
                    display.text?.append(sender.currentTitle!)
                }
                currNumber = Double(display.text!)!
            
            case "C":
                display.text="0"
                firstCharacter = true
                currNumber = 0
                clearBtn.setTitle("AC", for: .normal)
                dotted = false
            case "AC":
                display.text="0"
                firstCharacter = true
                currNumber = 0
                prevNumber = 0
                currOperation = nil
                dotted = false
            case ".":
                if !dotted {
                    display.text?.append(".")
                    firstCharacter = false
                }
                dotted = true
            case "±":
                if currNumber<0 {
                    display.text?.remove(at: (display.text?.startIndex)!)
                } else if currNumber>0 {
                    display.text?.insert("-", at: (display.text?.startIndex)!)
                }
                currNumber = currNumber * (-1)
            case "+":
                display.text = String(operationPressed(operation: .plus))
            case "-":
                display.text = String(operationPressed(operation: .minus))
            case "×":
                display.text = String(operationPressed(operation: .multiply))
            case "÷":
                display.text = String(operationPressed(operation: .divide))
            case "=":
                display.text = String(operationPressed(operation: .result))
            
            default: break
        }
    }
    
    func operationPressed(operation:operation)->Double {
        if currOperation == nil {
            currOperation = operation
            prevNumber = currNumber
            currNumber = 0
            dotted = false
            firstCharacter = true
        } else {
            prevNumber = performOperation()
            currOperation = operation
            currNumber = 0
            dotted = false
            dotted = false
            firstCharacter = true
        }
        return prevNumber
    }
    
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
            case .result:
                return prevNumber
            default: return 0
        }
    }

}

