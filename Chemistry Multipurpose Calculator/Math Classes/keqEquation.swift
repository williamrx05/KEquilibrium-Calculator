//
//  keqEquation.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

public class keqEquation {
    private var kEqValue: Double?
    private var numerator = [mathBrackets]()
    private var denominator = [mathBrackets]()
    private var kEqKnown = false
    private var poly = polynomial ()
    
    public init () {}
    
    public init (_ k: Double) { kEqValue = k; kEqKnown = true }
    
    public func getKEqValue () -> Double { return kEqValue ?? -1 }
    public func getTextFormNumerator () -> String {
        var output = ""
        for b in numerator {
            output.append (b.getTextForm())
        }
        return output
    }
    public func getTextFormDenominator () -> String {
        var output = ""
        for b in denominator {
            output.append (b.getTextForm())
        }
        return output
    }
    public func getTextForm () -> String {
        var leftSide: String = ""
        if (kEqKnown) {
            leftSide.append("\(kEqValue!) = ")
        } else {
            leftSide.append("Keq = ")
        }
        return ("\(leftSide)\(self.getTextFormNumerator()) / \(self.getTextFormDenominator())")
    }
    public func calculateKeq () {
        var tempBracket = mathBrackets ()
        let tempExpression = mathExpression ()
        tempExpression.addTerm(mathTerm (1))
        tempBracket.setExpression(tempExpression)
        
        for n in numerator {
            tempBracket = tempBracket.multiplyWith(n)
        }
        
        let numResult: Double = tempBracket.getTotalValue()
        var tempBracket2 = mathBrackets ()
        let tempExpression2 = mathExpression ()
        tempExpression2.addTerm(mathTerm (1))
        tempBracket2.setExpression(tempExpression2)
    
        for d in denominator {
            tempBracket2 = tempBracket2.multiplyWith(d)
        }
        
        let denResult: Double = tempBracket2.getTotalValue()
        kEqValue = Double (numResult/denResult)
    }
    public func toPolynomial () {
        let k = mathTerm (); k.setConstant(kEqValue ?? -1); k.setIsConstant(true)
        var tempBracket = mathBrackets ()
        var tempBracket2 = mathBrackets ()
        let tempExpression = mathExpression ()
        let tempTerm = mathTerm ()
        tempTerm.setIsConstant(true)
        tempExpression.addTerm(tempTerm)
        tempBracket.setExpression(tempExpression)
        tempBracket2.setExpression(tempExpression)
        for d in denominator {
            d.applyExponent()
            tempBracket = tempBracket.multiplyWith(d)
            
        }
        tempBracket.setExpression(tempBracket.getExpression().multiplyWith(k))
        for n in numerator {
            n.applyExponent()
            tempBracket2 = tempBracket2.multiplyWith(n)
        }
        tempBracket2.getExpression().negative()
        poly.setExpression ((tempBracket.addWith(tempBracket2)).getExpression())
        /*print (poly.getTextForm())
        for term in poly.getExpression().getTerm() {
            print (term.isConstant())
        }*/
        poly.getExpression().sort()
    }
    public func getPolynomialTextForm () -> String {
        return poly.getTextForm()
    }
    public func getPolynomial () -> polynomial {
        return poly
    }
    public func setKEqValue (_ k: Double) { kEqValue = k; kEqKnown = true }
    public func addToNumerator (_ me: mathExpression, _ e: Int) {
        let newBracket = mathBrackets ()
        newBracket.setExpression(mathExpression (me))
        newBracket.setExponent(e)
        numerator.append(newBracket)
    }
    public func addToDenominator (_ me: mathExpression, _ e: Int) {
        let newBracket = mathBrackets ()
        newBracket.setExpression(mathExpression (me))
        newBracket.setExponent(e)
        denominator.append(newBracket)
    }
}
