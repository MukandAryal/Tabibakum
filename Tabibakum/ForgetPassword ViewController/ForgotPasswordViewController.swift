//
//  ForgotPasswordViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 24/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

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
    
    func forgotPasswordApi(){
            LoadingIndicatorView.show()
            let param: [String: String] = [
                "email" : forgotPassword_txtFld.text!
            ]
            print(param)
            let api = Configurator.baseURL + ApiEndPoints.forgetPassword
            Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
                .responseJSON { response in
                  LoadingIndicatorView.hide()
                    print(response)
                    let resultDict = response.value as? [String: AnyObject]
                    if (resultDict?.keys.contains("data"))! {
                        let singUpObj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                        self.navigationController?.pushViewController(singUpObj!, animated: true)
                    }else {
                        let msg = resultDict!["message"] as? String
                        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
            }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func actionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSubmitBtn(_ sender: Any) {
        if forgotPassword_txtFld.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Please enter email id!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if forgotPassword_txtFld.text != nil {
            if !isValidEmail(testStr: forgotPassword_txtFld.text!)  {
                let alert = UIAlertController(title: "Alert", message: "Please enter valid email id!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }else {
            forgotPasswordApi()
        }
      }
    }
}
