//
//  molecule.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-13.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class molecule { // Group of elements
    private var element: element, value: Int
    public init (_ e: element,_ sub: Int) {
        element = e; value = sub
    }
    public func getElement () -> element {
        return element
    }
    public func getValue () -> Int {
        return value
    }
    public func addValue (_ x: Int) {
        value += x
    }
    public func totalValue (_ m: Int) -> Int { // Returns number of atoms contained
        return value * m
    }
}
