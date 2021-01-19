//
//  variable.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

public class variable { // x^2
    private var symbol: Character
    private var exponent: Int = 1
    private var value: Double?
    private var valueExists: Bool = false

    public init (_ c: Character) { symbol = c }
    public init (_ c: Character, _ e: Int) { symbol = c; exponent = e }
    public init (_ v: variable) { symbol = v.getSymbol(); exponent = v.getExponent(); valueExists = v.getExistance(); if (valueExists) { value = v.getValue() }}
    
    public func getExponent () -> Int { return exponent }
    public func getExistance () -> Bool { return valueExists }
    public func getValue () -> Double { return value! }
    public func getSymbol () -> Character { return symbol }
    public func getTotalValue () -> Double { return power (value!, exponent) }
    public func hasSameName (_ v: variable) -> Bool { if (self.getSymbol() == v.getSymbol()) { return true } else { return false } }
    public func hasSameExponent (_ v: variable) -> Bool { if (self.getExponent() == v.getExponent()) { return true } else { return false }}
    public func isEqualTo (_ v: variable) -> Bool { return self.hasSameName(v) && self.hasSameExponent(v)}
    public func addExponent (_ e: Int) { exponent += e }
    public func multiplyExponent (_ e: Int) { exponent *= e }
    public func setValue (_ d: Double) { value = d; valueExists = true }
    public func mergeWith (_ v: variable) -> variable { return variable (self.getSymbol(), self.getExponent() + v.getExponent()) }
}

