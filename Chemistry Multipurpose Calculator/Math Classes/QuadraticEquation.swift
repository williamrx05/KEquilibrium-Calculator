//
//  QuadraticEquation.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-23.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import Foundation

public func solveQuadraticEquation(_ cs: [Double]) -> [Double] {
    let a = cs[0]
    let b = cs[1]
    let c = cs[2]
    if a == 0.0 {
        var css = [Double] ()
        css.append (cs [1])
        css.append (cs[2])
        // seems linear equation
        let root = solveLinearEquation(css)
        return [root].filter({ !$0.isNaN })
    }

    let discriminant = pow(b, 2.0) - (4.0 * a * c) // D = b^2 - 4ac
    if discriminant < 0.0 {
        return []
    } else if discriminant == 0.0 {
        let root = -b / (2.0 * a)
        return [root]
    } else {
        let d = sqrt(discriminant)
        let root1 = (-b + d) / (2.0 * a)
        let root2 = (-b - d) / (2.0 * a)
        return [root1, root2]
    }
}
