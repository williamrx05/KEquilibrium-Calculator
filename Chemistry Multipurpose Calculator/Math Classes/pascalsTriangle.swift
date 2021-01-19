//
//  pascalsTriangle.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

public class pascalsTriangle {
    public init () {}
    
    public func factorial (_ n: Int) -> Int {
        if (n == 0) { return 1 }
        var result: Int = 1

        for i in 1...n {
            result *= i
        }
        return result
    }
    
    public func choose (_ n: Int, _ k: Int) -> Int {
        let top: Int = factorial(n)
        let bottom: Int = factorial(k)*factorial(n - k)
        return top/bottom
    }
    
    public func getCoefficientsOfRow (_ r: Int) -> [Int] {
        var coefficients = [Int]()
        for i in 0...r {
            coefficients.append(choose(r, i))
        }
        return coefficients
    }
}
