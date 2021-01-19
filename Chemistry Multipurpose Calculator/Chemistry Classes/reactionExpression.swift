//
//  reactionExpression.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class reactionExpression {
    private var terms = [reactionTerm](), statesRequired: Bool = false
    
    public init (_ s: String, _ states: Bool) {
        let termStrings = s.components (separatedBy: "+")
        for i in 0...termStrings.count - 1 {
            terms.append (reactionTerm(termStrings [i], states))
        }
    }
    
    public func getTextForm () -> String {
        var output: String = ""
        if (getNumTerms() > 0) {
            for i in 0...self.getNumTerms() - 1 {
                output.append (terms [i].getTextForm())
                if (i != self.getNumTerms() - 1) {
                    output.append (" + ")
                }
            }
        }
        return output
    }
    public func getTerm () -> [reactionTerm] {
        return terms
    }
    
    public func getTerm (_ i: Int) -> reactionTerm {
        return terms [i]
    }
    
    public func getNumTerms () -> Int {
        return terms.count
    }
    
    public func getTotalEachElement () -> [molecule] {
        var molecules = [molecule]()
        for i in 0...self.getNumTerms() - 1 { // Each term i
            let molsInTerm: [molecule] = terms [i].getTotalEachElement()
            if (molsInTerm.count > 0) {
                for x in 0...molsInTerm.count - 1 { // Each mol in each term x
                    let index = indexOfElement(molsInTerm [x].getElement(), molecules)
                    if (index != -1) {
                        molecules [index].addValue(molsInTerm [x].getValue())
                    } else {
                        molecules.append(molsInTerm [x])
                    }
                }
            }
        }
        return molecules
    }
}
