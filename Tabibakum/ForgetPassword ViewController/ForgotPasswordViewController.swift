//
//  ForgotPasswordViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 24/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordViewController: BaseClassViewController {
    
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
            self.showCustomProgress()
            let param: [String: String] = [
                "email" : forgotPassword_txtFld.text!
            ]
            print(param)
            let api = Configurator.baseURL + ApiEndPoints.forgetPassword + "?email=\(forgotPassword_txtFld.text!)"
            Alamofire.request(api, method: .post, parameters: nil, encoding: JSONEncoding.default)
                .responseJSON { response in
                 self.stopProgress()
                  //  print(response)
                    let resultDict = response.value as? [String: AnyObject]
                    print(resultDict)
                     let sucessStr = resultDict!["success"] as? String
                     let message = resultDict!["message"] as? String
                      //  print(sucessStr)
                    if sucessStr == "true"{
                            self.showCustomDialog()
                        }else{
                            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
            }
    }
    
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordLinkSentView") as? ForgotPasswordLinkSentView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.title_Lbl.text = "Resent password link sent sucessfully"
        exitVc!.okBtn.addTargetClosure { _ in
            popup.dismiss()
            self.exitBtn()
        }
        present(popup, animated: animated, completion: nil)
    }
    
    func exitBtn(){
        self.navigationController?.popViewController(animated: true)
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
            self.forgotPasswordApi()
        }
      }
    }
}
