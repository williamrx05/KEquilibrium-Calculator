//
//  element.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-13.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class element { // Unique element
    private var symbol: String
    public init (_ s: String) {
        symbol = s
    }
    public func getSymbol () -> String {
        return symbol
    }
    public func isEqualTo (_ e: element) -> Bool {
        return symbol == e.getSymbol()
    }
}
