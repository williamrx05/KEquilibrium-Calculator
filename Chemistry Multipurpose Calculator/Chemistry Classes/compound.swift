//
//  compound.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-13.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class compound { // Group of molecules (could contain brackets)
    private var molecules = [molecule](), brackets = [compoundBrackets]()
    // INIT FUNCTIONS
    public init () {
    }
    public init (_ m: [molecule]) {
        for i in 0...(m.count - 1) { molecules.append (m [i]) }// Molecules added by array
    }
    public init (_ m: [molecule],_ b: [compoundBrackets]) {
        for i in 0...(m.count - 1) { molecules.append (m [i]) } // Molecules added by array
        for i in 0...(b.count - 1) { brackets.append (b [i]) } // Molecules added by array
    }
    // GET FUNCTIONS
    public func indexesOf (_ s: String) -> [Int] { // Returns index of an element, and if it doesn't exist it returns -1 NOT TESTED
        var indexes = [Int]()
        for i in 0...molecules.count {
            if (molecules [i].getElement().getSymbol() == s) { indexes.append (i) }
        }
        if (indexes.count > 0) {
            return indexes
        } else {
            return [-1]
        }
    }
    public func getMolecule (_ i: Int) -> molecule {return molecules [i]} // Returns specific molecule based on index
    public func getMolecule () -> [molecule] {return molecules} // Returns all molecules in the molecules array
    public func getBracket (_ i: Int) -> compoundBrackets {return brackets [i]} // Returns specific bracket based on index
    public func getBracket () -> [compoundBrackets] {return brackets} //returns all brackets in the brackets array
    public func numMolecules () -> Int {return molecules.count} // Returns number of unique molecules
    public func numBrackets () -> Int {return brackets.count} // Returns number of unique brackets
    public func totalEachElement (_ coefficient: Int) -> [molecule] { // Returns total of elements
        let tempBracket = compoundBrackets (self, coefficient)
        return tempBracket.totalEachElement(1)
    }
    public func textForm () -> String { // Returns self in text form
        var s: String = ""
        if (self.numMolecules() > 0) {
            for i in 0...(molecules.count - 1) {
                let m = molecules [i]
                s.append(m.getElement().getSymbol())
                if (m.getValue() > 1) { // Excludes 1s
                    s.append(String (m.getValue()))
                }
            }
        }
        if (self.numBrackets() > 0) {
            for i in 0...(brackets.count - 1) {
                let b = brackets [i]
                s.append ("(")
                s.append (b.textForm())
                s.append (")")
                if (b.getMultiplier() > 1) {
                    s.append (String (b.getMultiplier()))
                }
            }
        }
        return s
    }
    // SET FUNCTIONS
    public func addMolecule (_ m: molecule) { // Appends a molecule to array molecules
        molecules.append(m)
    }
    public func addBracket (_ b: compoundBrackets) { // Appends a bracket to array bracket
        brackets.append(b)
    }
}
