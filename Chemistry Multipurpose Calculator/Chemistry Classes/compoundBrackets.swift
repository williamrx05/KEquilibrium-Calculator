//
//  compoundBrackets.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class compoundBrackets {
    private var comp: compound, multiplier: Int
    private var molecules = [molecule]()
    public init (_ m: Int) {
        comp = compound ()
        multiplier = m
    }
    public init (_ c: compound,_ m: Int) {
        comp = c; multiplier = m
    }
    public func getCompound () -> compound { return comp } // Returns the compound the bracket houses
    public func getMultiplier () -> Int { return multiplier } // Returns the multiplier around the bracket
    public func textForm () -> String {
        return comp.textForm()
    }
    public func totalEachElement (_ multi: Int) -> [molecule] { // Returns molecules within the bracket with the total number as the subscript
        if (comp.numMolecules() > 0) {
            for i in 0...(comp.numMolecules() - 1) { // Individual molecules in the compound within the brackets
                let mol: molecule = comp.getMolecule(i)
                let newMol: molecule = molecule (mol.getElement(), mol.totalValue(multiplier*multi))
                appendMolecule(newMol)
            }
        }
        if (comp.numBrackets() > 0) {
            for i in 0...(comp.numBrackets() - 1) {
                let mols = comp.getBracket (i).totalEachElement(multiplier*multi)
                if (mols.count > 1) {
                    for m in 0...(mols.count - 1) {
                        appendMolecule (mols [m])
                    }
                }
            }
        }
        return molecules
    }

    func appendMolecule (_ m: molecule) { // Adds to the number of molecules
        var i = -1
        if (molecules.count != 0) {
            i = indexOfElement(m.getElement(), molecules)
        }
        if (i != -1) {
            molecules [i].addValue(m.getValue()) // If the element exists within m already, then add the value
            //print ("\(molecules[i].getElement().getSymbol()) added with value \(m.getValue())")
        } else {
            molecules.append (m) // If the element doesn't exist within m already, then append the molecule
            //print ("\(m.getElement().getSymbol()) appended with value \(m.getValue())")
        }
    }
}
