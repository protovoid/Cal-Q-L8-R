//
//  ViewController.swift
//  Cal-Q-L8-R
//
//  Created by Chad on 8/1/16.
//  Copyright © 2016 Chad Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  @IBOutlet fileprivate weak var display: UILabel!
  
  fileprivate var userIsInTheMiddleOfTyping = false
  
  @IBAction fileprivate func touchDigit(_ sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTyping {
      let textCurrentlyInDisplay = display.text!
      display.text = textCurrentlyInDisplay + digit
    } else {
      display.text = digit
    }
    userIsInTheMiddleOfTyping = true
    // print("touched \(digit) digit")
    
  }
  
  fileprivate var displayValue: Double  {
    get {
      return Double(display.text!)!
    }
    set {
      display.text = String(newValue)
    }
  }
  
  fileprivate var brain = CalculatorBrain()
  
  @IBAction fileprivate func performOperation(_ sender: UIButton) {
    if userIsInTheMiddleOfTyping {
      brain.setOperand(displayValue)
      userIsInTheMiddleOfTyping = false
    }
    
    if let mathematicalSymbol = sender.currentTitle {
      brain.performOperation(mathematicalSymbol)
      
      /* // moved into CalculatorBrain.swift model file
       if mathematicalSymbol == "π" {
       displayValue = M_PI
       // display.text = String(M_PI)
       } else if mathematicalSymbol == "√" {
       displayValue = sqrt(displayValue)
       */
      
    }
    displayValue = brain.result
  }
  
  var decimalPressed = false
  
  @IBAction func decimalButtonPressed(_ sender: UIButton) {
    userIsInTheMiddleOfTyping = true
    if decimalPressed == false {
      display.text = display.text! + "."
      decimalPressed = true
    }
  }
  
  
  
  
  @IBAction func clearDisplayButton(_ sender: UIButton) {
    userIsInTheMiddleOfTyping = false
    brain.clearDisplay()
    displayValue = 0
  }
  
  
  
  
  
  
  
  
  
}

