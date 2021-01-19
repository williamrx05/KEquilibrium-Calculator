//
//  LinearEquation.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-23.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import Foundation

public func solveLinearEquation(_ cs: [Double]) -> Double {
    let a = cs[0]
    let b = cs[1]
    if a == 0.0 {
        return .nan
    } else {
        let root = -b / a
        return root
    }
}
