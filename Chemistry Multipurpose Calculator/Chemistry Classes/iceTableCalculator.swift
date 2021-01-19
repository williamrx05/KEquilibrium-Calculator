//
//  iceTable.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-16.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class iceTable {
    private var rightSide = [termColumn]()
    private var leftSide = [termColumn]()
    private var Keq: Double?
    private var KeqExists: Bool = false
    
    public init (_ re: reactionEquation) {
        if (re.getNumExpressions() == 2) {
            for term in re.getExpression(0).getTerm() {
                leftSide.append (termColumn (term))
            }
            for term in re.getExpression(1).getTerm() {
                rightSide.append (termColumn (term))
            }
        }
    }
    public func getKeqEquation () -> keqEquation {
        let equation = keqEquation ()
        for column in leftSide {
            equation.addToDenominator(column.getFinalMolExpression(), column.getTerm().getCoefficient())
        }
        for column in rightSide {
            equation.addToNumerator(column.getFinalMolExpression(), column.getTerm().getCoefficient())
        }
        equation.setKEqValue(Keq ?? -1)
        return equation
    }
    public func printTable () {
        var allSides = [termColumn]()
        allSides.append(contentsOf: leftSide)
        allSides.append(contentsOf: rightSide)
        let middle = leftSide.count
        var text = ""
        for i in 0...allSides.count - 1 {
            if (i == middle) { text.append ("=") } else if (i != 0) { text.append ("+") }
            text.append (" \(allSides[i].getTerm().getTextForm()) ")
        }
        print (text)
        text = ""
        for i in 0...allSides.count - 1 {
            if (i == middle) { text.append ("|") }
            text.append (" \(String (allSides[i].getInitial())) ")
        }
        print (text)
        text = ""
        for i in 0...allSides.count - 1 {
            if (i == middle) { text.append ("|") }
            if (allSides[i].getChange() < 0) {
                text.append (" \(allSides[i].getChange())x ")
            } else {
                text.append (" +\(allSides[i].getChange())x ")
            }
        }
        print (text)
        text = ""
        for i in 0...allSides.count - 1 {
            if (i == middle) { text.append ("|") }
            if (allSides[i].getFinal() == 0) {
            text.append (" \(allSides[i].getFinalMolExpression().getTextForm()) ")
            } else {
                text.append (" \(allSides[i].getFinal()) ")
            }
        }
        print (text)
    }
    
    public func getKeqExists () -> Bool { return KeqExists }
    public func getKeq () -> Double { return Keq ?? -1 }
    public func getRightColumn (_ i: Int) -> termColumn { return rightSide[i] }
    public func getLeftColumn (_ i: Int) -> termColumn { return leftSide[i] }
    public func checkAnswer (_ d: Double) -> Bool {
        var allSides = [termColumn]()
        allSides.append(contentsOf: leftSide)
        allSides.append(contentsOf: rightSide)
        for column in allSides {
            let expression = column.getFinalMolExpression()
            expression.getTerm(expression.getNumTerms() - 1).getVariable(0).setValue(d)
            if (expression.getTotalValue() <= 0) {
                return false
            }
        }
        return true
    }
    
    public func setKeqValue (_ k: Double) { Keq = k; KeqExists = true }
    
    public func reverse () {
        if KeqExists {
            Keq = 1/(Keq ?? -1)
        }
        swap(&rightSide, &leftSide)
    }
    public func changeRightSigns () {
        for column in rightSide {
            column.changeSign()
        }
    }
    public func changeLeftSigns () {
        for column in leftSide {
            column.changeSign()
        }
    }
    public func applyXValue (_ x: Double) {
        var allSides = [termColumn]()
        allSides.append(contentsOf: leftSide)
        allSides.append(contentsOf: rightSide)
        for column in allSides {
            column.applyFoundVariable(x)
        }
    }
}
