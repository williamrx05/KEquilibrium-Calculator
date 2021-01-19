//
//  reactionTerm.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-13.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class reactionTerm { // Compound with coefficient and state of matter
    private var comp: compound = compound (), state: String = "Unknown", coefficient: Int = 1, statesRequired: Bool = false
    
    public init (_ s: String, _ states: Bool) {
        var str = s
        coefficient = getCoefficientFromString(str)
        if (coefficient == -1) {
            coefficient = 1
        } else {
            str = str.substring (from: coefficient.usefulDigits)
        }
        if (states) {
            state = getStateFromString(str)
            if (state == "Liquid" || state == "Gas" || state == "Solid" || state == "Unknown") {
                str = str.substring (to: str.length - 1)
            } else if (state == "Aqueous") {
                str = str.substring (to: str.length - 2)
            }
        }
        comp = stringToCompound(str)
    }
    
    public func getCompound () -> compound { return comp }
    public func getState () -> String { return state }
    public func getCoefficient () -> Int { return coefficient }
    public func getTotalEachElement () -> [molecule] { return (comp.totalEachElement(coefficient)) }
    public func getTextForm () -> String {
        var output: String = ""
        if (coefficient != 1) {
            output.append ("\(String (coefficient))")
        }
        output.append (comp.textForm())
        if (state != "Unknown") {
            if (state == "Gas") {
                output.append ("g")
            } else if (state == "Solid") {
                output.append ("s")
            } else if (state == "Liquid") {
                output.append ("l")
            }
        }
        return output
    }
    public func getCoefficientFromString (_ s: String) -> Int {
        if (Character(s[0]).isNumber) {
            return getFirstNumber(s)
        } else {
            return -1
        }
    }
    
    public func getStateFromString (_ s: String) -> String {
        let lastLetter = s[s.length - 1]
        if (lastLetter == "?") {
            return "Unknown"
        } else if (lastLetter == "s") {
            return "Solid"
        } else if (lastLetter == "g") {
            return "Gas"
        } else if (lastLetter == "l") {
            return "Liquid"
        } else if (lastLetter == "q" && s[s.length - 2] == "a") {
            return "Aqueous"
        }
        return "X"
    }
    
    public func stringToCompound (_ s: String) -> compound {
        let output = compound ()
        var i = 0
        var name = ""
        var value = 1
        
        while i < (s.length) {
            let letter: Character = Character (s [i])
            if (letter.isUppercase) {
                if (name != "") {
                    output.addMolecule(molecule(element(name),value))
                    name = String (letter)
                    value = 1
                } else {
                    name.append(letter)
                }
            } else if (letter.isNumber) {
                value = getFirstNumber(s.substring(from: i))
                if (value != -1) { // If there is in fact a number ahead
                    i += value.usefulDigits - 1
                    output.addMolecule(molecule(element(name),value))
                } else { // If no number ahead
                    value = 1
                    output.addMolecule(molecule(element(name),value))
                }
                name = ""; value = 1
            } else if (letter.isLowercase) {
                name.append (letter)
            } else if (letter == "(") {
                if (i != 0 && name != "") {
                    output.addMolecule(molecule(element(name),value))
                    name = ""; value = 1
                }
                let indexOpenB = i
                let indexCloseB = findNextBracket(s.substring(from: indexOpenB)) // Index of outermost bracket"
                var nextMultiplier = getFirstNumber(s.substring(from: indexOpenB + indexCloseB + 1)) // Index of possible number (1 after outermost bracket)
                if (nextMultiplier == -1) { // Sets next multiplier to 1
                    nextMultiplier = 1
                    i += indexCloseB // One after bracket
                } else {
                    i += indexCloseB + nextMultiplier.usefulDigits // One after number after bracket
                }
                let innerCompound = stringToCompound(s[indexOpenB + 1..<indexOpenB + indexCloseB])
                output.addBracket(compoundBrackets(innerCompound, nextMultiplier))
            }
            if (i == s.count - 1 && name != "" && name != "(") {
                if (Character(name[0]).isUppercase) {
                    output.addMolecule(molecule(element(name),value))
                }
            }
            i += 1
        }
        return output
    }
}
