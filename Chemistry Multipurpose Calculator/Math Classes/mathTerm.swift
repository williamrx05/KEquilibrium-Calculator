//
//  mathTerm.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

public class mathTerm { // 5x^2y^2, or is simply a constant like 5
    private var constant: Double = 1
    private var variables = [variable]()
    private var isConst: Bool = false
    
    public init () {}
    public init (_ m: mathTerm) { constant = m.getConstant(); variables = m.getVariable(); isConst = m.isConstant() }
    public init (_ c: Double) { constant = c; isConst = true }
    public init (_ c: Double, _ v: variable) { constant = c; self.addVariable(v) }
    
    public func isConstant () -> Bool { return isConst }
    public func getConstant () -> Double { return constant }
    public func getNumVariables () -> Int { return variables.count }
    public func getVariable () -> [variable] { return variables }
    public func getVariable (_ i: Int) -> variable { return variables [i] }
    public func getSign () -> String { if (constant < 0) { return "-" } else { return "+" } }
    public func getTextForm () -> String {
        var output = ""
        if (self.isConstant()) {
            if (self.getConstant() < 0) {
                output.append ("\((-1*constant).toString())")
            } else {
                output.append ("\(constant.toString())")
            }
        } else {
            if (self.getConstant() != 1 && self.getConstant() != -1) {
                if (self.getSign() == "-") {
                    output.append ("\((-1*constant).toString())")
                } else {
                    output.append ("\(constant.toString())")
                }
            }
            if (self.getNumVariables() > 0) {
                for variable in variables {
                    output.append (variable.getSymbol())
                    if (variable.getExponent() != 1) {
                        output.append ("^\(variable.getExponent())")
                    }
                }
            }
        }
        return output
    }
    public func getIndexOfVariable (_ v: variable) -> Int {
        if (self.getNumVariables() > 0) {
            for i in 0...self.getNumVariables() - 1 {
                if (self.getVariable(i).hasSameName(v)) {
                    return i
                }
            }
        }
        return -1
    }
    public func getIndexOfVariable (_ v: variable, _ array: [variable]) -> Int {
        if (array.count > 0) {
            for i in 0...array.count - 1 {
                if (array [i].hasSameName(v)) {
                    return i
                }
            }
        }
        return -1
    }
    public func isEqualTypeTo (_ t: mathTerm) -> Bool {
        if (self.isConstant() && t.isConstant()) {
            return true
        } else if (t.getNumVariables() != self.getNumVariables()) {
            return false
        } else if (!self.isConstant() && !t.isConstant()) {
            for v in t.getVariable() {
                let index = self.getIndexOfVariable(v)
                if (index == -1) {
                    return false
                } else if (!self.getVariable(index).isEqualTo(v)) {
                    return false
                }
            }
        }
        return true
    }
    public func isEqualTo (_ t: mathTerm) -> Bool {
        if (self.isConstant() && t.isConstant()) {
            if (self.getConstant() == t.getConstant()) {
                return true
            }
            return false
        } else if (t.getNumVariables() != self.getNumVariables()) {
            return false
        } else if (!self.isConstant() && !t.isConstant()) {
            for v in t.getVariable() {
                let index = self.getIndexOfVariable(v)
                if (index == -1) {
                    return false
                } else if (!self.getVariable(index).isEqualTo(v)) {
                    return false
                }
            }
        }
        return true
    }
    public func getTotalValue () -> Double {
        if (self.isConstant()) {
            return constant
        } else {
            var result = constant
            for v in variables {
                result *= v.getTotalValue()
            }
            return result
        }
    }
    
    public func flipSign () { constant *= -1 }
    public func setIsConstant (_ c: Bool) { isConst = c}
    public func setConstant (_ c: Double) { constant = c }
    public func addConstant (_ c: Double) { constant += c }
    public func multiplyConstant (_ c: Double) { constant *= c }
    public func addVariable (_ v: variable) { variables.append (variable (v)) }
    public func simplify () {
        if (self.getNumVariables() > 0) {
            var newVariables = [variable]()
            for v in variables {
                let index = self.getIndexOfVariable(v, newVariables)
                if (index == -1) {
                    newVariables.append (v)
                } else {
                    newVariables [index].addExponent(v.getExponent())
                }
            }
            variables = newVariables
        }
    }
    public func multiplyWith (_ t: mathTerm) -> mathTerm {
        let newTerm = mathTerm ()
        newTerm.setConstant(self.getConstant()*t.getConstant())
        //print ("Multiplying \(self.getTextForm()) (\(self.isConstant()) with \(t.getTextForm()) (\(t.isConstant()))")
        if (self.isConstant() && t.isConstant()) {
            newTerm.setIsConstant(true)
            return newTerm
        }
        for v in self.getVariable() {
            newTerm.addVariable(v)
        }
        for v in t.getVariable()
        {
            newTerm.addVariable(v)
        }
        newTerm.simplify()
        return newTerm
    }
    public func toThePowerOf (_ e: Int) -> mathTerm { // earlier issue
        let newTerm = mathTerm ()
        if (e == 0) {
            newTerm.setConstant(1)
            newTerm.setIsConstant(true)
            return newTerm
        }
        newTerm.setConstant(power (self.getConstant(), e))
        if (!self.isConstant()) {
            for i in self.getVariable() {
                let v = variable (i)
                v.multiplyExponent(e)
                newTerm.addVariable(v)
            }
        } else {
            newTerm.setIsConstant(true)
        }
        return newTerm
    }
}
