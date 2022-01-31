//
//  CalcModel.swift
//  CalculatorApp
//
//  Created by Nurdana Rakhymova on 1/4/22.
//

import Foundation

enum Operation {
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation ((Double,Double)->Double)
    case percent
    case negativeSign
    case equals
    case clearAll
}

//func addition(op1:Double, op2:Double)->Double{
//    op1+op2
//}
//{$0+$1}

struct CalculatorModel{
    var my_operation: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "+": Operation.binaryOperation({(op1:Double, op2:Double) in
            return op1+op2
        }),
        "-": Operation.binaryOperation({(op1:Double,op2:Double) in
            return op1-op2
        }),
        "×": Operation.binaryOperation({(op1:Double,op2:Double) in
            return op1*op2
        }),
        "÷": Operation.binaryOperation({(op1:Double,op2:Double) in
            return op1/op2
        }),
        "%": Operation.percent,
//        "±": Operation.negativeSign({(op1:Double) in
//            return op1*(-1)}),
        "±": Operation.negativeSign,
        "C": Operation.clearAll,
        "=": Operation.equals
    ]
    private var global_value: Double?
    
    mutating func setOperand(_ operand:Double){
        global_value=operand
    }
    mutating func performOperation (_ operation:String){
        let symbol=my_operation[operation]
        switch symbol {
        case .constant(let value):
            global_value=value
        case .unaryOperation(let function):
            global_value=function(global_value!)
        case .binaryOperation(let function):
            saving=SaveFirstOperandAndOperation(firstOperand: global_value!, operation: function)
        case .percent:
            global_value=global_value!/100
        case .negativeSign:
            global_value=global_value!*(-1)
        case .clearAll:
            global_value=0
        case .equals:
            global_value=saving?.performOperationWith(secondOperand: global_value!)
        default:
            break
        }
    }
    func getResult()->Double?{
        return global_value
    }
    
    private var saving: SaveFirstOperandAndOperation?
    
    struct SaveFirstOperandAndOperation {
        let firstOperand:Double
        let operation:(Double, Double)->Double
        
        func performOperationWith(secondOperand op2:Double)->Double{
            return operation(firstOperand, op2)
        }
    }
    
//    private var savingFirst: SaveFirstOperand?
//
//    struct SaveFirstOperand {
//        let firstOperand:Double
//        let operation:(Double)->Double
//
//        func performOperation()->Double{
//            return operation(firstOperand)
//        }
//    }
}
