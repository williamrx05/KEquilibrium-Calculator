//
//  Global.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-13.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

extension UILabel {
    /// Sets the attributedText property of UILabel with an attributed string
    /// that displays the characters of the text at the given indices in subscript.
    func setAttributedTextWithSubscripts(_ text: String, _ indicesOfSubscripts: [Int]) {
        let font = self.font!
        let subscriptFont = font.withSize(font.pointSize * 0.7)
        let subscriptOffset = -font.pointSize * 0.3
        let attributedString = NSMutableAttributedString(string: text,
                                                         attributes: [.font : font])
        for index in indicesOfSubscripts {
            let range = NSRange(location: index, length: 1)
            attributedString.setAttributes([.font: subscriptFont,
                                            .baselineOffset: subscriptOffset],
                                           range: range)
        }
        self.attributedText = attributedString
    }
}

extension String { // Extension to make things work out
    var length: Int {return count}
    subscript (i: Int) -> String {return self[i ..< i + 1]}
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
     subscript(_ range: CountableRange<Int>) -> String {
         let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                              range.upperBound - range.lowerBound))
         return String(self[start..<end])
     }

     subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
         let start = index(startIndex, offsetBy: max(0, range.lowerBound))
          return String(self[start...])
     }
}

func letterToState (_ letter: Character) -> String { // Returns state of matter based on letter received
    var state: String = "?"
    if (letter == "g") {state = "Gas"} else if (letter == "l") {state = "Liquid"} else if (letter == "a") { } else if (letter == "s") {state = "Solid"}
    return state
}

func findNextBracket (_ s: String) -> Int { // Finds the next bracket
    var innerDepth: Int = 0
    var index: Int = -1
    
    for i in 0...(s.length - 1) {
        let letter: Character = Character (s[i])
        if (letter == "(") {
            innerDepth -= 1
        } else if (letter == ")") {
            innerDepth += 1
            if (innerDepth == 0) {
                index = i
                break
            }
        }
    }
    return index
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var removingAllWhitespaces: Self {
        filter { !$0.isWhitespace }
    }
    mutating func removeAllWhitespaces() {
        removeAll(where: \.isWhitespace)
    }
}

extension Int { // Extension to make things work out
    var usefulDigits: Int {
        let num = self
        let numString = String (num)
        return numString.count
    }
}

func getInt(_ data:String) -> Int {// Returns Int from String
    return Int(data) ?? -1
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
func getFirstNumber (_ str: String) -> Int { // Returns the number at the start of a string, and if none, it returns -1
    var number: Int = -1
    if (str.count > 1) {
        for i in 1...(str.count - 1) {
            if (getInt (str.substring(to: i)) != -1) {
                number = getInt (str.substring (to: i)) ?? -1
            } else if (getInt (str.substring(to: i)) == -1) {
                break
            }
        }
    } else {
        number = getInt(str) ?? -1
    }
    return number
}

func indexOfElement (_ e: element, _ m: [molecule]) -> Int { // Returns index of an element, and if it doesn't exist it returns -1
    if (m.count > 0) {
        for i in 0...(m.count - 1) {
            if (m [i].getElement().isEqualTo(e)) { return i }
        }
    }
    return -1
}

func power (_ b: Double, _ e: Int) -> Double {
    var result: Double = 1
    if (e > 0) {
        for _ in 0...e - 1 {
            result *= b
        }
    }
    return result
}  

func moleculeArraysEqual (_ m1: [molecule], _ m2: [molecule]) -> Bool {
    if (m1.count != m2.count || m1.count == 0 || m2.count == 0) {
        return false
    }
    for standardMolecule in m1 {
        let index = indexOfElement(standardMolecule.getElement(), m2)
        if (index == -1) {
            return false
        } else {
            if (standardMolecule.getValue() != m2 [index].getValue()) {
                //print ("Molecule \(standardMolecule.getElement().getSymbol()) found on both sides, except one side had \(standardMolecule.getValue()) while the other side had \(m2 [index].getValue())")
                return false
            }
        }
    }
    return true
}

func removeSpaces (_ s: String) -> String{
    var output: String = ""
    let inputWithoutSpaces = s.components (separatedBy: " ")
    for i in 0...inputWithoutSpaces.count - 1 {
        output.append (inputWithoutSpaces[i])
    }
    return output
}

extension UIView {
    var textFieldsInView: [UITextField] {
        return subviews
            .filter ({ !($0 is UITextField) })
            .reduce (( subviews.compactMap { $0 as? UITextField }), { summ, current in
                return summ + current.textFieldsInView
        })
    }
    var selectedTextField: UITextField? {
        return textFieldsInView.filter { $0.isFirstResponder }.first
    }
}

