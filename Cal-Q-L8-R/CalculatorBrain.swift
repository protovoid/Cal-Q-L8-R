//
//  CalculatorBrain.swift
//  Cal-Q-L8-R
//
//  Created by Chad on 8/2/16.
//  Copyright © 2016 Chad Williams. All rights reserved.
//

import Foundation

class CalculatorBrain
{
  private var accumulator = 0.0
  
  func setOperand(operand: Double) {
    accumulator = operand
  }
  
  var operations: Dictionary<String,Double> = [
    "π" : M_PI,
    "e" : M_E 
  ]
  
  func performOperation(symbol: String) {
    switch symbol {
    case "π": accumulator = M_PI
    case "√": accumulator = sqrt(accumulator)
    default: break
    }
  }
  
  var result: Double {
    get {
      return accumulator
    }
  }
}
