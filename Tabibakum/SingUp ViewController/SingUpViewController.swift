//
//  SingUpViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 23/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class SingUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var userImg_View: UIImageView!
    @IBOutlet weak var fullName_txtFld: UITextField!
    @IBOutlet weak var phoneNumber_txtFld: UITextField!
    @IBOutlet weak var emailAddress_txtFld: UITextField!
    @IBOutlet weak var yourPassword_txtFld: UITextField!
    @IBOutlet weak var confirmPassword_txtFld: UITextField!
    @IBOutlet weak var singUpBtn: UIButton!
    @IBOutlet weak var phoneNumberView: UIView!
    
    let imagePicker = UIImagePickerController()
    var imgToUpload = Data()
    
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
        
        imagePicker.delegate = self
        userImg_View.layer.cornerRadius = userImg_View.frame.height/2
        userImg_View.clipsToBounds = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func singUp(name:String,email:String,phone:String,password:String,type:String,countyCode:String,device_token:String,profileImg:Data){
        
        LoadingIndicatorView.show()
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(name.data(using: String.Encoding.utf8)!, withName: "name")
                multipartFormData.append(email.data(using: String.Encoding.utf8)!, withName: "email")
                multipartFormData.append(password.data(using: String.Encoding.utf8)!, withName: "password")
                multipartFormData.append(type.data(using: String.Encoding.utf8)!, withName: "type")
                multipartFormData.append(phone.data(using: String.Encoding.utf8)!, withName: "phone")
                multipartFormData.append(countyCode.data(using: String.Encoding.utf8)!, withName: "country_code")
                multipartFormData.append(device_token.data(using: String.Encoding.utf8)!, withName: "device_token")
                // if let imageData = UIImageJPEGRepresentation(img, 0.5) {
                multipartFormData.append(self.imgToUpload, withName: "avatar", fileName: "\(String(NSDate().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")).jpeg", mimeType: "image/jpeg")
                // }
                print(multipartFormData)
        },
            to:"\(Configurator.baseURL)\(ApiEndPoints.register)",
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response)
                        LoadingIndicatorView.hide()
                        var resultDict = response.value as? [String:AnyObject]
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
                        .uploadProgress { progress in // main queue by default
                            print("Upload Progress: \(progress.fractionCompleted)")
                    }
                    return
                case .failure(let encodingError):
                    debugPrint(encodingError)
                }
        })
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        userImg_View.image = selectedImage
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            imgToUpload = imageData
        }
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func actionAddphoto(_ sender: Any) {
        showAlert()
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        let loginObj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginObj, animated: true)
    }
    
    @IBAction func actionSubmitBtn(_ sender: Any) {
//        let img = UIImage(named: "user_pic")
//        if userImg_View.image == img {
//            let alert = UIAlertController(title: "Alert", message: "Please choose profile photo!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if fullName_txtFld.text == ""{
//            let alert = UIAlertController(title: "Alert", message: "Please enter full name!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if (phoneNumber_txtFld.text?.count)!<10{
//            let alert = UIAlertController(title: "Alert", message: "Please enter valid number!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if emailAddress_txtFld.text == "" {
//            let alert = UIAlertController(title: "Alert", message: "Please enter email Id!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if ((yourPassword_txtFld.text?.count)!)<8 {
//            let alert = UIAlertController(title: "Alert", message: "Password set minimum 8 character!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if yourPassword_txtFld.text == "" {
//            let alert = UIAlertController(title: "Alert", message: "Please enter password number!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if confirmPassword_txtFld.text == "" {
//            let alert = UIAlertController(title: "Alert", message: "Please enter confirm password number!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if yourPassword_txtFld.text != confirmPassword_txtFld.text {
//            let alert = UIAlertController(title: "Alert", message: "Password does not match!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if emailAddress_txtFld.text != nil {
//            if !isValidEmail(testStr: emailAddress_txtFld.text!)  {
//                let alert = UIAlertController(title: "Alert", message: "Please enter valid email id!", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }else{
//                self.singUp(name: fullName_txtFld.text!, email: emailAddress_txtFld.text!, phone: phoneNumber_txtFld.text!, password: phoneNumber_txtFld.text!, type: "0", countyCode: "+964", device_token: "fIcOhEIJwpE:APA91bGSNKBqmQOr3BnXL5aOLH-iAJ5M5VvbdpQT4FzSVxW8dw7U-3BTT35cm52JfsobjVMJ183cDAqVIEBLMylRg-h5k8U7H_2PoJJoA3t0cqwh-ZMjko1VjfFdk6ifq2cNEt4B35JL", profileImg: imgToUpload)
//            }
//        }
        let loginObj = self.storyboard?.instantiateViewController(withIdentifier: "singUpPatientWelcomeScreenViewController") as! singUpPatientWelcomeScreenViewController
        self.navigationController?.pushViewController(loginObj, animated: true)
    }
}

extension SingUpViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumber_txtFld  {
            let charsLimit = 10
            let startingLength = phoneNumber_txtFld.text?.characters.count ?? 0
            let lengthToAdd = string.characters.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            return newLength <= charsLimit
        } else {
            return true
        }
    }
}



