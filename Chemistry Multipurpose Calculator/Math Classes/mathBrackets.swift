//
//  mathBrackets.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

public class mathBrackets {
    private var expression: mathExpression = mathExpression ()
    private var exponent: Int = 1
    
    public init () {}
    public init (_ m: mathBrackets) {
        expression = mathExpression (m.getExpression())
        exponent = m.getExponent()
    }
    
    public func getExponent () -> Int { return exponent }
    public func getExpression () -> mathExpression { return expression }
    public func getTextForm () -> String {
        var output = "(\(expression.getTextForm()))"
        if (exponent != 1) {
            output.append ("^\(exponent)")
        }
        return output
    }
    public func getTotalValue () -> Double {
        return expression.getTotalValue()
    }
    
    public func setExpression (_ e: mathExpression) { expression = mathExpression (e)}
    
    public func setExponent (_ i: Int) { exponent = i }
    public func applyExponent () {
        let newExpression: mathExpression = mathExpression()
        if (self.getExponent() > 1) {
            if (self.getExpression().getNumTerms() == 2) {
                let coefficients: [Int] = pascalsTriangle ().getCoefficientsOfRow(exponent)
                for i in 0...exponent {
                    let a = expression.getTerm(0).toThePowerOf(exponent - i)
                    let b = expression.getTerm(1).toThePowerOf(i)
                    a.multiplyConstant(Double (coefficients[i]))
                    newExpression.addTerm(a.multiplyWith(b))
                }
                expression = mathExpression (newExpression)
                expression.simpify()
                expression.cleanseZeroes()
            } else if (self.getExpression().getNumTerms() == 1) {
                newExpression.addTerm (mathTerm (expression.getTerm(0).toThePowerOf(exponent)))
                expression = mathExpression (newExpression)
            }
        } else if (self.getExponent() == 0) {
            print ("yes")
            let newTerm = mathTerm ()
            newTerm.setIsConstant(true)
            newExpression.addTerm(newTerm)
            expression = mathExpression(newExpression)
        }
        exponent = 1
    }
    public func multiplyWith (_ b: mathBrackets) -> mathBrackets {
        let newBracket = mathBrackets()
        newBracket.setExpression(expression.multiplyWith(b.getExpression()))
        return newBracket
    }
    public func addWith (_ b: mathBrackets) -> mathBrackets {
        let newBracket = mathBrackets()
        for term in expression.getTerm() {
            newBracket.getExpression().addTerm(term)
        }
        for term in b.getExpression().getTerm() {
            newBracket.getExpression().addTerm(term)
        }
        newBracket.getExpression().simpify()
        newBracket.getExpression().cleanseZeroes()
        return newBracket
    }
}
