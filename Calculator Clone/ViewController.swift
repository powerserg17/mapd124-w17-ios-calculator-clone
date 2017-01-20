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
    var currNumber: Double = 1
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
            
            case "C":
                display.text="0"
                firstCharacter = true
                currNumber = 0
                clearBtn.setTitle("AC", for: .normal)
            case "AC":
                display.text="0"
                firstCharacter = true
                currNumber = 0
                prevNumber = 0
                currOperation = nil
            case "±":
                if currNumber<0 {
                    display.text?.remove(at: (display.text?.startIndex)!)
                } else if currNumber>0 {
                    display.text?.insert("-", at: (display.text?.startIndex)!)
                }
                currNumber = currNumber * (-1)
            
            
            default: break
        }
    }

}

