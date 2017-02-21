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
  fileprivate var accumulator = 0.0
  
  fileprivate var descriptionAccumulator = "0"
  
  var description: String {
    get {
      if pending == nil {
        return descriptionAccumulator
      } else {
        return pending!.descriptionFunction(pending!.descriptionOperand, pending!.descriptionOperand != descriptionAccumulator ? descriptionAccumulator : "")
      }

  }

    }
  
  
  var isPartialResult: Bool {
    get {
      return pending != nil
    }
  }
  // needs to return true if binary operation pending, otherwise false
  
  func setOperand(_ operand: Double) {
    accumulator = operand
  }
  
  fileprivate var operations: Dictionary<String,Operation> = [
    "π" : Operation.constant(M_PI),
    "e" : Operation.constant(M_E),
    "√" : Operation.unaryOperation(sqrt, { "√(" + $0 + ")"}),
    "sin" : Operation.unaryOperation(sin, { "sin(" + $0 + ")"}),
    "cos" : Operation.unaryOperation(cos, { "cos(" + $0 + ")"}),
    "tan" : Operation.unaryOperation(tan, { "tan(" + $0 + ")"}),
    
    "±" : Operation.unaryOperation({ -$0 }, { "-(" + $0 + ")"}),
    
    
    "×" : Operation.binaryOperation(*, { $0 + " × " + $1 }, 1),
    "÷" : Operation.binaryOperation(/, { $0 + " ÷ " + $1 }, 1),
    "+" : Operation.binaryOperation(+, { $0 + " + " + $1 }, 0),
    "-" : Operation.binaryOperation(-, { $0 + " - " + $1 }, 0),
    "=" : Operation.equals,
    "rand" : Operation.nullaryOperation(drand48, "rand()"),
    
    
  ]
  
  fileprivate enum Operation {
    case constant(Double)
    case unaryOperation((Double) -> Double, (String) -> String)
    case binaryOperation((Double, Double) -> Double, (String, String) -> String, Int)
    case equals
    case nullaryOperation(() -> Double, String)
  }
  
  fileprivate var currentPrecedence = Int.max
  
  func performOperation(_ symbol: String) {
    if let operation = operations[symbol] {
      switch operation {
      case .constant(let value): accumulator = value
        
      case .unaryOperation(let function, let descriptionFunction): accumulator = function(accumulator)
        descriptionAccumulator = descriptionFunction(descriptionAccumulator)
        
      case .binaryOperation(let function, let descriptionFunction, let precedence): executePendingBinaryOperation()
      if currentPrecedence < precedence {
        descriptionAccumulator = "(" + descriptionAccumulator + ")"
        }
        currentPrecedence = precedence
        pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator, descriptionFunction: descriptionFunction, descriptionOperand: descriptionAccumulator)
      
      // pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
        
      case .equals:
        executePendingBinaryOperation()
        
      case .nullaryOperation(let function, let descriptionValue):
        accumulator = function()
        descriptionAccumulator = descriptionValue
              }
    }
    }
  
  func clearDisplay() {
    accumulator = 0
  }
  
  fileprivate func executePendingBinaryOperation()
  {
    if pending != nil {
      accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
      pending = nil
    }

  }
  
  fileprivate var pending: PendingBinaryOperationInfo?
  
  fileprivate struct PendingBinaryOperationInfo {
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
    var descriptionFunction: (String, String) -> String
    var descriptionOperand: String
  }
    
    /*
     switch symbol {
     case "π": accumulator = M_PI
     case "√": accumulator = sqrt(accumulator)
     default: break
     }
     */
  
  
  var result: Double {
    get {
      return accumulator
    }
  }
}
