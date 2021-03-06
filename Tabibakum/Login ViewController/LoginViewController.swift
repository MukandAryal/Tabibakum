//
//  LoginViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 22/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: BaseClassViewController {
    @IBOutlet weak var phoneNumber_txtFld: UITextField!
    @IBOutlet weak var password_txtFld: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var back_btn: UIBarButtonItem!
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
       // phoneNumber_txtFld.text = "2222222222"
        //password_txtFld.text = "12345678"
        loginBtn.backgroundColor = UiInterFace.appThemeColor

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func loginApi(){
        
        let deviceToken = UserDefaults.standard.string(forKey: "DeviceToken")
        let param: [String: String] = [
            "phone" : phoneNumber_txtFld.text!,
            "country_code" : "+964",
            "password" : password_txtFld.text!,
            "device_token" : deviceToken!
        ]
        
        print(param)
        self.showCustomProgress()
        let api = Configurator.baseURL + ApiEndPoints.login
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
               // print(response)
                let resultDict = response.value as? AnyObject
                if let token = resultDict!["token"] as? String{
                        print("sucessss")
                        let token = resultDict!["token"] as? String
                        UserDefaults.standard.set(token, forKey: "loginToken")
                        indexingValue.questionNaireType = "singUpQuestionNaire"
                       //setObject
                      self.getUserDetails()
                }else {
                    let alert = UIAlertController(title: "Alert", message: "Invalid User Name or Password!", preferredStyle: UIAlertController.Style.alert);                      alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                        self.stopProgress()
                        self.present(alert, animated: true, completion: nil)
                }
         }
    }
    
    func getUserDetails(){
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
       
        let api = Configurator.baseURL + ApiEndPoints.user_details + "?token=\(loginToken ?? "")"
        
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
              //  print(response)
                self.stopProgress()
                let resultDict = response.value as? NSDictionary
                if let userDetails = resultDict!["user"] as? NSDictionary {
                let totalfilled = userDetails.object(forKey: "totalfilled") as! Int
                let loginType =  userDetails.object(forKey: "type") as! Int
                let verified =  userDetails.object(forKey: "verified") as! Int
                let userid =  userDetails.object(forKey: "id") as! Int
                UserDefaults.standard.set(userid, forKey: "userid")
                UserDefaults.standard.set(loginType, forKey: "loginType")
                UserDefaults.standard.set(totalfilled, forKey: "totalfilled")
                if loginType == 0 {
                    print(totalfilled)
                    if totalfilled == 1 {
                   if let OBj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as? HomeViewController {
                    self.navigationController?.pushViewController(OBj, animated: true)
                        }
                        UserDefaults.standard.set(self.phoneNumber_txtFld.text, forKey: "loginPhoneNumber")
                        UserDefaults.standard.set(self.password_txtFld.text, forKey: "loginPasswordNumber")
                        print("last index")
                    }else{
                        self.questionNaireApi()
                    }
                }else{
                    if totalfilled == 1 {
                        self.stopProgress()
                        if verified == 0 {
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "doctorSingUpCompleteViewController")as! doctorSingUpCompleteViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                        }else {
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorHomeViewController")as! DoctorHomeViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                            UserDefaults.standard.set(self.phoneNumber_txtFld.text, forKey: "loginPhoneNumber")
                            UserDefaults.standard.set(self.password_txtFld.text, forKey: "loginPasswordNumber")
                        }
                    }else{
                        indexingValue.questionNaireType = "DoctorSingUpQuestionNaire"
                        self.questionNaireApi()
                    }
                }
            }
        }
    }
    
    func questionNaireApi(){
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        var api = String()
        let loginType = UserDefaults.standard.string(forKey: "loginType")
        let param: [String: Any] = [
            "token" : loginToken!
        ]
        if loginType == "1" {
            api = Configurator.baseURL + ApiEndPoints.doctoranswer
        }else{
            api = Configurator.baseURL + ApiEndPoints.patientanswer
        }
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                
             //   print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let type = specialistObj["type"] as? String
                    indexingValue.questionType.append(type!)
                    indexingValue.indexValue = 0
                    print(indexingValue.questionType)
                }
                self.stopProgress()
                if indexingValue.questionType.count == indexingValue.indexValue {
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                    print("last index")
                }
                else if indexingValue.questionType[indexingValue.indexValue] == "text"{
                    print("text")
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireTextViewController")as! QuestionNaireTextViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                }else if indexingValue.questionType[indexingValue.indexValue] == "yesno"{
                    print("yes")
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionYesNoViewController")as! QuestionYesNoViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                }else if indexingValue.questionType[indexingValue.indexValue] == "list"{
                    print("list")
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "ListQuestionNaireViewController")as! ListQuestionNaireViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                }else if indexingValue.questionType[indexingValue.indexValue] == "image"{
                    print("image")
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireImageViewController")as! QuestionNaireImageViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                }else if indexingValue.questionType[indexingValue.indexValue] == "tab1"{
                    print("tab1")
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireSingalTabViewController")as! QuestionNaireSingalTabViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                }else if indexingValue.questionType[indexingValue.indexValue] == "tab2"{
                    print("tab2")
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireMultipleTabViewController")as! QuestionNaireMultipleTabViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                }else if indexingValue.questionType[indexingValue.indexValue] == "tai"{
                    print("tai")
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QueestionNaireImgeAndTextViewController")as! QueestionNaireImgeAndTextViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                }
                indexingValue.indexValue = +1
        }
    }
    
    
    @IBAction func actionloginBtn(_ sender: Any) {
        if phoneNumber_txtFld.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please enter phone number!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if (phoneNumber_txtFld.text?.count)!<10{
            let alert = UIAlertController(title: "Alert", message: "Please enter valid number!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if password_txtFld.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Please enter password number!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            loginApi()
        }
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        let loginObj = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        self.navigationController?.pushViewController(loginObj
            , animated:true)
        
    }
    
    @IBAction func actionSingUp(_ sender: Any) {
        let loginObj = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
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

extension LoginViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumber_txtFld  {
            let charsLimit = 10
            let startingLength = phoneNumber_txtFld.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            return newLength <= charsLimit
        } else {
            return true
        }
    }
}
