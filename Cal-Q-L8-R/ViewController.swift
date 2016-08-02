//
//  ViewController.swift
//  Cal-Q-L8-R
//
//  Created by Chad on 8/1/16.
//  Copyright © 2016 Chad Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  @IBOutlet weak var display: UILabel!
  
  var userIsInTheMiddleOfTyping = false
  
  @IBAction func touchDigit(sender: UIButton) {
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
  
  @IBAction func performOperation(sender: UIButton) {
    userIsInTheMiddleOfTyping = false 
    if let mathematicalSymbol = sender.currentTitle {
      if mathematicalSymbol == "π" {
        display.text = String(M_PI)
      }
    }
  }
  
  
  
  
  
  
  
  // MARK: DEFAULT FUNCTIONS

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

