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
  
  private var descriptionAccumulator = "0"
  
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
  
  func setOperand(operand: Double) {
    accumulator = operand
  }
  
  private var operations: Dictionary<String,Operation> = [
    "π" : Operation.Constant(M_PI),
    "e" : Operation.Constant(M_E),
    "√" : Operation.UnaryOperation(sqrt, { "√(" + $0 + ")"}),
    "sin" : Operation.UnaryOperation(sin, { "sin(" + $0 + ")"}),
    "cos" : Operation.UnaryOperation(cos, { "cos(" + $0 + ")"}),
    "tan" : Operation.UnaryOperation(tan, { "tan(" + $0 + ")"}),
    "×" : Operation.BinaryOperation(*, { $0 + " x " + $1 }, 1),
    "÷" : Operation.BinaryOperation(/, { $0 + " ÷ " + $1 }, 1),
    "+" : Operation.BinaryOperation(+, { $0 + " + " + $1 }, 0),
    "-" : Operation.BinaryOperation(-, { $0 + " - " + $1 }, 0),
    "=" : Operation.Equals,
    "rand" : Operation.NullaryOperation(drand48, "rand()")
    
  ]
  
  private enum Operation {
    case Constant(Double)
    case UnaryOperation((Double) -> Double, (String) -> String)
    case BinaryOperation((Double, Double) -> Double, (String, String) -> String, Int)
    case Equals
    case NullaryOperation(() -> Double, String)
  }
  
  private var currentPrecedence = Int.max
  
  func performOperation(symbol: String) {
    if let operation = operations[symbol] {
      switch operation {
      case .Constant(let value): accumulator = value
        
      case .UnaryOperation(let function, let descriptionFunction): accumulator = function(accumulator)
        descriptionAccumulator = descriptionFunction(descriptionAccumulator)
        
      case .BinaryOperation(let function, let descriptionFunction, let precedence): executePendingBinaryOperation()
      if currentPrecedence < precedence {
        descriptionAccumulator = "(" + descriptionAccumulator + ")"
        }
        currentPrecedence = precedence
        pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator, descriptionFunction: descriptionFunction, descriptionOperand: descriptionAccumulator)
      
      // pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
        
      case .Equals:
        executePendingBinaryOperation()
      case .NullaryOperation(let function, let descriptionValue):
        accumulator = function()
        descriptionAccumulator = descriptionValue
              }
    }
    }
  
  func clearDisplay() {
    accumulator = 0
  }
  
  private func executePendingBinaryOperation()
  {
    if pending != nil {
      accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
      pending = nil
    }

  }
  
  private var pending: PendingBinaryOperationInfo?
  
  private struct PendingBinaryOperationInfo {
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
