//
//  polynomial.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//
import UIKit

public class polynomial {
    private var expression = mathExpression ()
    
    public init () {}
    public init (_ e: mathExpression) {
        expression = mathExpression(e)
    }
    
    public func getExpression () -> mathExpression { return expression }
    public func getTextForm () -> String { return ("\(expression.getTextForm()) = 0")}
    public func getConstants (_ d: Int) -> [Double] {
        var constants = [Double]()
        var i: Int = d
        
        for y in 0...expression.getTerm().count - 1 {
            let term = expression.getTerm(y)
            if (!term.isConstant()) {
                if (term.getVariable(0).getExponent() == i) {
                    constants.append(term.getConstant())
                } else {
                    for x in 0...i {
                        if (term.getVariable(0).getExponent() == x) {
                            constants.append(term.getConstant())
                            break
                        } else {
                            constants.append(0)
                            i -= 1
                        }
                    }
                }
            } else {
                if (i > 0) {
                    for _ in 0...i - 1 {
                        constants.append (0)
                    }
                    i = 0
                }
                constants.append (term.getConstant())
            }
            i -= 1
        }
        if (i > 0) {
            for _ in 0...i {
                constants.append (0)
            }
        }
        return constants
    }
    
    public func setExpression (_ e: mathExpression) { expression = mathExpression(e) }
    
    public func solve () -> [Double] {
        var result = [Double]()
        let degree = expression.getTerm(0).getVariable(0).getExponent()
        if (degree < 4) { // Can only solve 3, 2, 1
            if (degree == 1) {
                result.append(solveLinearEquation(getConstants(degree)))
            } else if (degree == 2) {
                return (solveQuadraticEquation(getConstants(degree)))
            } else if (degree == 3) {
                return (solveCubicEquation(getConstants(degree)))
            }
        }
        return result
    }
    /*
    func solveQuadratic (_ c: [Double]) -> [Double] {
        var result = [Double]()
        let a: Double = c[0]
        let b: Double = c[1]
        let c: Double = c[2]
        let bSquared = power(b, 2)
        let discriminant = bSquared - (4 * a * c)
        let isImaginary = discriminant < 0
        let sqrtDiscriminant = sqrt(fabs(discriminant))
        
        if isImaginary {
            print ("Imaginary Numbers")
        } else {
            let topFormula: Double = sqrtDiscriminant - b
            let bottomFormula: Double = 2 * a
            let x1 = topFormula / bottomFormula
            
            let topFormula2: Double = -sqrtDiscriminant - b
            let x2 = topFormula2 / bottomFormula
            result.append (x1)
            result.append (x2)
        }
        return result
    }*/
}
