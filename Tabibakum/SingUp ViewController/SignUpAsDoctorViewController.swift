//
//  SignUpAsDoctorViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 24/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class SignUpAsDoctorViewController: UIViewController {

    @IBOutlet weak var speciallization_view: UIView!
    
    @IBOutlet weak var fullName_txtFld: UITextField!
    @IBOutlet weak var phoneNumber_txtFld: UITextField!
    @IBOutlet weak var emailAddress_txtFld: UITextField!
    @IBOutlet weak var yourPassword_txtFld: UITextField!
    @IBOutlet weak var confirmPassword_txtFld: UITextField!
    @IBOutlet weak var singUpBtn: UIButton!
    
    @IBOutlet weak var phoneNumberView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fullName_txtFld.layer.cornerRadius = 5
        fullName_txtFld.clipsToBounds = true
        fullName_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        fullName_txtFld.layer.borderWidth = 0.5
        
        phoneNumberView.layer.cornerRadius = 5
        phoneNumberView.clipsToBounds = true
        phoneNumberView.layer.borderColor = UIColor.lightGray.cgColor
        phoneNumberView.layer.borderWidth = 0.5
        
        speciallization_view.layer.cornerRadius = 5
        speciallization_view.clipsToBounds = true
        speciallization_view.layer.borderColor = UIColor.lightGray.cgColor
        speciallization_view.layer.borderWidth = 0.5
        
        
        emailAddress_txtFld.layer.cornerRadius = 5
        emailAddress_txtFld.clipsToBounds = true
        emailAddress_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        emailAddress_txtFld.layer.borderWidth = 0.5
        
        yourPassword_txtFld.layer.cornerRadius = 5
        yourPassword_txtFld.clipsToBounds = true
        yourPassword_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        yourPassword_txtFld.layer.borderWidth = 0.5
        
        confirmPassword_txtFld.layer.cornerRadius = 5
        confirmPassword_txtFld.clipsToBounds = true
        confirmPassword_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        confirmPassword_txtFld.layer.borderWidth = 0.5
        
        singUpBtn.layer.cornerRadius = singUpBtn.frame.height/2
        singUpBtn.clipsToBounds = true
        
        fullName_txtFld.setLeftPaddingPoints(10)
        phoneNumber_txtFld.setLeftPaddingPoints(10)
        emailAddress_txtFld.setLeftPaddingPoints(10)
        confirmPassword_txtFld.setLeftPaddingPoints(10)
        yourPassword_txtFld.setLeftPaddingPoints(10)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func actionLoginBtn(_ sender: Any) {
        let loginObj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
         self.navigationController?.pushViewController(loginObj!, animated: true)
    }
    
    
    @IBAction func actionBack_Btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
