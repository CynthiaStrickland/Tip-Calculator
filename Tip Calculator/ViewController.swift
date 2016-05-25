//
//  ViewController.swift
//
//  Created by Cynthia Whitlatch on 5/20/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import QuartzCore


class ViewController: UIViewController, UITextFieldDelegate {
    
    var initialBillAmount = ""
    var percentageForTipAmount = ""
    var tipAmountCalculated : Float = 0.0
    var finalBillAmount : Float = 0.0
    let gold = UIColor(hexString: "#ffe700ff")
    let buttonColor = UIColor(red:0.98, green:0.82, blue:0.03, alpha:1.0).CGColor as CGColorRef
    let buttonBorder = UIColor.whiteColor().CGColor

    
    @IBOutlet weak var totalBill: UITextField!
    @IBOutlet weak var percentageForTip: UITextField!
    
    @IBOutlet weak var calculateTip: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalBillWithTip: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customButton()
    }
    
    
    @IBAction func buttonPressed(sender: UIButton) {
        calculateTipAmount()
    }
    
    @IBAction func ClearButtonPressed(sender: AnyObject) {
        clearLabels()
        
    }
    
    func calculateTipAmount() {
        
        if totalBill.text! == "" && percentageForTip.text! == "" {
            let alertView = UIAlertController(title: "Error",
                                              message: "Please enter the bill and tip amounts" as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Thank you", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
        } else {
            
            initialBillAmount = totalBill.text!
            percentageForTipAmount = percentageForTip.text!
            
            //CHANGE TextFields back to Floats to do calculation
            
            let fInitialBillAmount = Float(initialBillAmount)
            let fPercentageForTipAmount = Float(percentageForTipAmount)
            
            tipAmountCalculated = fInitialBillAmount! * (fPercentageForTipAmount!/100)
            finalBillAmount = fInitialBillAmount! + tipAmountCalculated
            
            displayTip()
            hideKeyboards()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hideKeyboards()
    }
    
    func hideKeyboards() {
        totalBill.resignFirstResponder()
        percentageForTip.resignFirstResponder()
    }
    
    func displayTip() {
        
        let formatTip = String(format: "%0.02f", tipAmountCalculated)
        let formatBill = String(format: "%0.02f", finalBillAmount)
        
        tipAmount.text = "Tip Amount = $\(formatTip)"
        totalBillWithTip.text = "Total Bill with Tip = $\(formatBill)"
        
    }
    
    func clearLabels() {
        totalBill.text = ""
        percentageForTip.text = ""
        
        tipAmount.text = "Tip $0.00"
        totalBillWithTip.text = "Total Bill $0.00"
        
        hideKeyboards()
    }
    
    func customButton() {
        
        calculateTip.layer.borderColor = buttonBorder // Set border color
        calculateTip.layer.borderWidth = 1
        calculateTip.layer.cornerRadius = 10
        calculateTip.layer.backgroundColor = buttonColor
        
        clearButton.layer.borderColor = buttonBorder
        clearButton.layer.borderWidth = 1
        clearButton.layer.cornerRadius = 10
        clearButton.layer.backgroundColor = buttonColor
        
        tipAmount.layer.borderColor = buttonBorder
        tipAmount.layer.backgroundColor  = buttonColor
        tipAmount.layer.borderWidth = 1
        tipAmount.layer.cornerRadius = 10
        
        totalBillWithTip.layer.borderColor = buttonBorder
        totalBillWithTip.layer.backgroundColor  = buttonColor
        totalBillWithTip.layer.borderWidth = 1
        totalBillWithTip.layer.cornerRadius = 10
    }
    
    
}


extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.startIndex.advancedBy(1)
            let hexColor = hexString.substringFromIndex(start)
            
            if hexColor.characters.count == 8 {
                let scanner = NSScanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexLongLong(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

