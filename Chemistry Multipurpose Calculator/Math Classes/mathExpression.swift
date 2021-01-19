//
//  mathExpression.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

public class mathExpression {
    private var terms = [mathTerm]()
    
    public init () {}
    public init (_ m: mathExpression) {
        terms = m.getTerm()
    }
    
    public func getNumTerms () -> Int { return terms.count }
    public func getTerm () -> [mathTerm] { return terms }
    public func getTerm (_ i: Int) -> mathTerm { return terms [i] }
    public func getTextForm () -> String {
        var output = ""
        if (terms.count > 0) {
            for i in 0...terms.count - 1 {
                let term = terms [i]
                if (i != 0) {
                    output.append (" \(term.getSign()) ")
                } else if (i == 0 && term.getConstant() < 0) {
                    output.append ("\(term.getSign())")
                }
                output.append (terms [i].getTextForm())
            }
        }
        return output
    }
    public func getIndexOfType (_ t: mathTerm) -> Int {
        if (self.getNumTerms() > 0) {
            for i in 0...self.getNumTerms() - 1 {
                if (self.getTerm(i).isEqualTypeTo(t)) {
                    return i
                }
            }
        }
        return -1
    }
    public func getIndexOfType (_ t: mathTerm, _ array: [mathTerm]) -> Int {
        if (array.count > 0) {
            for i in 0...array.count - 1 {
                if (array [i].isEqualTypeTo(t)) {
                    return i
                }
            }
        }
        return -1
    }
    public func getTotalValue () -> Double {
        var result: Double = 0
        for t in terms {
            result += t.getTotalValue()
        }
        return result
    }

    public func addTerm (_ t: mathTerm) { terms.append(mathTerm(t)) }
    public func simpify () {
        if (self.getNumTerms() > 0) {
            var newTerms = [mathTerm]()
            for t in terms {
                let index = getIndexOfType(t, newTerms)
                if (index == -1) {
                    newTerms.append(t)
                } else {
                    newTerms [index].addConstant(t.getConstant())
                }
            }
            terms = newTerms
        }
    }
    public func cleanseZeroes () {
        var newTerms = [mathTerm]()
        for t in terms {
            if (t.getConstant() != 0) {
                newTerms.append(t)
            }
        }
        terms = newTerms
    }
    public func multiplyWith (_ e: mathExpression) -> mathExpression {
        let newExpression = mathExpression()
        for i in self.getTerm() {
            for u in e.getTerm() {
                newExpression.addTerm (i.multiplyWith(u))
            }
        }
        newExpression.simpify()
        newExpression.cleanseZeroes()
        return newExpression
    }
    public func multiplyWith (_ t: mathTerm) -> mathExpression {
        let newExpression = mathExpression()
        for i in self.getTerm() {
            newExpression.addTerm(i.multiplyWith(t))
        }
        newExpression.simpify()
        newExpression.cleanseZeroes()
        return newExpression
    }
    public func negative () {
        for i in self.getTerm() {
            i.flipSign()
        }
    }
    public func sort () {
        var newTerms = [mathTerm]()
        var indexOfConstant = -1
        for i in 0...terms.count - 1 {
            if (!terms [i].isConstant()) {
                newTerms.append(terms [i])
            } else {
                indexOfConstant = i
            }
        }
        var sortedNewTerms = newTerms.sorted(by: { (term1: mathTerm, term2: mathTerm) in
            return term1.getVariable(0).getExponent() > term2.getVariable(0).getExponent()
        })
        if (indexOfConstant != -1) {
            sortedNewTerms.append (terms[indexOfConstant])
        }
        terms = sortedNewTerms
    }
}
