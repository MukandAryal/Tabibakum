//
//  LoginViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 22/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var phoneNumber_txtFld: UITextField!
    @IBOutlet weak var password_txtFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumber_txtFld.layer.borderWidth = 0.5
        phoneNumber_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        password_txtFld.layer.borderWidth = 0.5
        password_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        phoneNumber_txtFld.layer.cornerRadius = 5
        phoneNumber_txtFld.clipsToBounds = true
        password_txtFld.layer.cornerRadius = 5
        password_txtFld.clipsToBounds = true
        phoneNumber_txtFld.setLeftPaddingPoints(10)
        password_txtFld.setLeftPaddingPoints(10)
        loginBtn.layer.cornerRadius = loginBtn.frame.height/2
        loginBtn.clipsToBounds = true
    
     
}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func ActionloginBtn(_ sender: Any) {
        let loginObj = self.storyboard?.instantiateViewController(withIdentifier: "SingUpViewController") as! SingUpViewController
        self.navigationController?.pushViewController(loginObj
            , animated:true)
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
     self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSingUp(_ sender: Any) {
        let loginObj = self.storyboard?.instantiateViewController(withIdentifier: "SingUpViewController") as! SingUpViewController
        self.navigationController?.pushViewController(loginObj
                   , animated:true)
    }
    
    @IBAction func actionForgotPasswordBtn(_ sender: Any) {
   let forgotpassObj = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(forgotpassObj
            , animated:true)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
