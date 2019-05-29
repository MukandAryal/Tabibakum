//
//  ForgotPasswordViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 24/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var forgotPassword_txtFld: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()

       forgotPassword_txtFld.layer.cornerRadius = 5
        forgotPassword_txtFld.clipsToBounds = true
        forgotPassword_txtFld.layer.borderWidth = 0.5
        forgotPassword_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        submitBtn.layer.cornerRadius = submitBtn.frame.height/2
        submitBtn.clipsToBounds = true
        forgotPassword_txtFld.setLeftPaddingPoints(10)
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func actionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
