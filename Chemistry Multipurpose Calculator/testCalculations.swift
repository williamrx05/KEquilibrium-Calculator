//
//  testCalculations.swift
//  Chemistry Multipurpose CalculatorTests
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import Foundation

func testingProgram () {
    let x = variable ("x") // x
    
    let term1 = mathTerm ()
    term1.addVariable(x)
    term1.flipSign()
    
    let term2 = mathTerm ()
    term2.setConstant(1.17)
    term2.setIsConstant(true)
    
    let term3 = mathTerm ()
    term3.addVariable(x)
    term3.setConstant(2)
    
    
    let expression1 = mathExpression () // (1.17 - x)
    expression1.addTerm(term2)
    expression1.addTerm(term1)
    
    let expression2 = mathExpression () // 2x
    expression2.addTerm(term3)
    
    let KEQ = keqEquation (49.6)
    KEQ.addToNumerator(expression2, 2)
    KEQ.addToDenominator(expression1, 1)
    KEQ.addToDenominator(expression1, 1)
    print (KEQ.getTextForm())
    KEQ.toPolynomial()
    print (KEQ.getPolynomialTextForm())
}

testingProgram()
