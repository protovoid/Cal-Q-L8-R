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
  
  private var description: String {
    get {
      return "" // sequence of operands that led to value returned by result
      // "=" and "..." should never appear
  }
    set {
      // ???
    }
  }
  
  private var isPartialResult = false
  // needs to return true if binary operation pending, otherwise false
  
  func setOperand(operand: Double) {
    accumulator = operand
  }
  
  private var operations: Dictionary<String,Operation> = [
    "π" : Operation.Constant(M_PI),
    "e" : Operation.Constant(M_E),
    "√" : Operation.UnaryOperation(sqrt),
    "sin" : Operation.UnaryOperation(sin),
    "cos" : Operation.UnaryOperation(cos),
    "tan" : Operation.UnaryOperation(tan),
    "×" : Operation.BinaryOperation({ $0 * $1 }),
    "÷" : Operation.BinaryOperation({ $0 / $1 }),
    "+" : Operation.BinaryOperation({ $0 + $1 }),
    "-" : Operation.BinaryOperation({ $0 - $1 }),
    "=" : Operation.Equals
    
  ]
  
  private enum Operation {
    case Constant(Double)
    case UnaryOperation((Double) -> Double)
    case BinaryOperation((Double, Double) -> Double)
    case Equals
  }
  
  func performOperation(symbol: String) {
    if let operation = operations[symbol] {
      switch operation {
      case .Constant(let value): accumulator = value
      case .UnaryOperation(let function): accumulator = function(accumulator)
      case .BinaryOperation(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
      case .Equals:
        executePendingBinaryOperation()
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
