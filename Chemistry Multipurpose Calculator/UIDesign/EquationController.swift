//
//  EquationController.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-18.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class EquationController: UIViewController {
    @IBOutlet var equationView: UIView!
    @IBOutlet var equationLabel: UILabel!
    @IBOutlet var constantLabel: UILabel!
    @IBOutlet var equationTextField: UITextField!
    @IBOutlet var constantTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var calculateButton: UIButton!
    
    private var equationText: String = ""
    private var equation: reactionEquation = reactionEquation ()

    public override func viewDidLoad() {
        constantLabel.setAttributedTextWithSubscripts ("Enter Keq", [7, 8])
        super.viewDidLoad()
        errorLabel.alpha = 0
        calculateButton.isEnabled = false
    }
    
    func errorOccured (_ error: String, _ e: Bool) {
        if !e {
            errorLabel.alpha = 0
            calculateButton.isEnabled = true
            print (calculateButton.isEnabled)
        } else {
            errorLabel.alpha = 1
            calculateButton.isEnabled = false
            errorLabel.text = error
        }
    }
    
    func checkValidSyntax(_ s: String) -> Bool {
        var numE = 0
        var numB1 = 0
        var numB2 = 0
        for c in s {
            if (c == "=") { numE += 1 }
            else if (c == "(") { numB1 += 1 }
            else if (c == ")") { numB2 += 1 }
            else if (!c.isNumber && !c.isLetter && c != " " && c != "+") { return false }
        }
        if numE != 1 { return false }
        else if numB1 != numB2 { return false }
        return true
    }
    
    func checkValidEquation (_ re: reactionEquation) -> Bool {
        if (re.getExpression(0).getNumTerms() > 3 || re.getExpression(1).getNumTerms() > 3) { return false }
        if (re.getExpression(0).getNumTerms() == 0 || re.getExpression(1).getNumTerms() == 0) { return false }
        print (re.getExpression(0).getNumTerms())
        return true
    }
    
    @IBAction func equationTextFieldDidEndEditing (_ textField: UITextField) {
        if let text = textField.text, text != "" {
            equationText = text
            print ("Valid Syntax: \(checkValidSyntax(equationText))")
            if (checkValidSyntax (equationText)) {
                equation = reactionEquation (equationText, false)
                if checkValidEquation(equation) {
                    print ("Valid Equation: \(equation.getTextForm ())")
                    errorLabel.alpha = 0
                } else {
                    equation = reactionEquation ()
                    errorOccured ("Error: Invalid Equation", true)
                }
            } else {
                errorOccured("Error: Invalid Input", true)
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        if let textField = equationView.selectedTextField {
           textField.resignFirstResponder ()
        }
    }
}
