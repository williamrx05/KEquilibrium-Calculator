//
//  SettingsController.swift
//  Chemistry Multipurpose Calculator
//
//  Created by William X on 2020-06-26.
//  Copyright © 2020 Ultra Edge Apps. All rights reserved.
//

import UIKit

public class SettingsController: UIViewController {
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var step1: UILabel!
    @IBOutlet weak var step1TextField: UITextField!
    @IBOutlet weak var step2: UILabel!
    @IBOutlet weak var step2TextField: UITextField!
    @IBOutlet weak var step3a: UILabel!
    @IBOutlet weak var caption3a: UILabel!
    @IBOutlet weak var step3b: UILabel!
    @IBOutlet weak var caption3b: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image3a: UIImageView!
    @IBOutlet weak var image3b: UIImageView!
    @IBOutlet weak var step4: UILabel!
    
    public override func viewDidLoad() {
        step1TextField.backgroundColor = UIColor (named: "TextFieldBackgroundColor")
        step2TextField.backgroundColor = UIColor (named: "TextFieldBackgroundColor")
        exitButton.titleLabel?.font = buttonFont
        settingsLabel.font = defaultFont
        step1.font = textFieldFont
        step1TextField.font = textFieldFont
        step2.font = textFieldFont
        step2TextField.font = textFieldFont
        step3a.font = textFieldFont
        caption3a.font = captionFont
        step3b.font = textFieldFont
        caption3b.font = captionFont
        step4.font = textFieldFont
        if UIDevice.current.orientation.isLandscape {
            scrollView.contentSize.height = 625
        } else {
            scrollView.contentSize.height = 700
        }
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            scrollView.contentSize.height = 625
        } else {
            scrollView.contentSize.height = 700
        }
    }
    
    @IBAction func exitButton (_ button: Any) {
        dismiss(animated: true, completion: nil)
    }
}
