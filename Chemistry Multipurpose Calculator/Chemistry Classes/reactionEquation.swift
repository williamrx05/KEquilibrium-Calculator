//
//  reactionEquation.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class reactionEquation {
    private var expressions = [reactionExpression](), statesRequired: Bool = false
    
    public init (_ s: String, _ states: Bool) {
        let expressionStrings = s.components (separatedBy: "=")
        for i in 0...expressionStrings.count - 1 {
            expressions.append(reactionExpression(expressionStrings [i], statesRequired))
        }
    }
    public func getTextForm () -> String {
        var output: String = ""
        if (getNumExpressions() > 0) {
            for i in 0...self.getNumExpressions() - 1 {
                output.append(expressions [i].getTextForm())
                if (i != self.getNumExpressions() - 1) {
                    output.append (" = ")
                }
            }
        }
        return output
    }
    
    public func getExpression () -> [reactionExpression] {
        return expressions
    }
    
    public func getExpression (_ i: Int) -> reactionExpression {
        return expressions [i]
    }
    public func getNumExpressions () -> Int {
        return expressions.count
    }
    
    public func isBalanced () -> Bool{
        if (expressions.count > 1) {
            let standard: [molecule] = expressions [0].getTotalEachElement()
            for expression in expressions {
                if (!moleculeArraysEqual(standard, expression.getTotalEachElement())) {
                    return false
                }
            }
        }
        return true
    }
}
