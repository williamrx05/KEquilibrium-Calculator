//
//  termColumn.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class termColumn {
    private var term: reactionTerm, initialMols: Double = 0, changeMultiplier: Int = -1, finalMols: Double = 0, valid: Bool = true, side: Int = -1
    
    public init (_ t: reactionTerm, _ direction: Int) {
        term = t
        if (term.getState() == "Solid") { valid = false }
        side *= direction
    }
    
    public func getInitial () -> Double { return initialMols }
    public func getChange () -> Int { return changeMultiplier }
    public func getSide () -> Int { return side }
    public func getFinal () -> Double { return finalMols }
    
    public func changeSide () {
        changeMultiplier *= -1
        side *= -1
    }
    
    public func setInitialMols (_ x: Float64) {
        initialMols = x
    }
    
}
