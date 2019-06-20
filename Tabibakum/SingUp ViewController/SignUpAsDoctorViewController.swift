//
//  SignUpAsDoctorViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 24/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

struct specilist {
    var id : Int
    var created_at : String
    var specialist : String
}

class SignUpAsDoctorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var userImg_View: UIImageView!
    @IBOutlet weak var speciallization_view: UIView!
    @IBOutlet weak var fullName_txtFld: UITextField!
    @IBOutlet weak var phoneNumber_txtFld: UITextField!
    @IBOutlet weak var emailAddress_txtFld: UITextField!
    @IBOutlet weak var yourPassword_txtFld: UITextField!
    @IBOutlet weak var confirmPassword_txtFld: UITextField!
    @IBOutlet weak var singUpBtn: UIButton!
    @IBOutlet weak var phoneNumberView: UIView!
    
    @IBOutlet weak var select_speciallzationLbl: UILabel!
    
    @IBOutlet weak var dropDownTblView: UITableView!
    
    @IBOutlet weak var specialization_dropDownView: UIView!
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var childView: UIView!
    
    @IBOutlet weak var alradyAcccountView: UIView!
    
    @IBOutlet weak var phone_Lbl: UILabel!
    
    @IBOutlet weak var email_addressLbl: UILabel!
    
    @IBOutlet weak var password_Lbl: UILabel!
    @IBOutlet weak var confimpassword_lbl: UILabel!
    @IBOutlet weak var fullname_lbl: UILabel!
    
    @IBOutlet weak var country_codeLbl: UIButton!
    
    let imagePicker = UIImagePickerController()
    var imgToUpload = Data()
    var specialistArr = [String]()
    var selectedLangCategries = [String]()
    
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
        
        imagePicker.delegate = self
        userImg_View.layer.cornerRadius = userImg_View.frame.height/2
        userImg_View.clipsToBounds = true
        
        specialization_dropDownView.isHidden = true
        specialization_dropDownView.layer.cornerRadius = 10
        specialization_dropDownView.clipsToBounds = true
        
        specializationListApi()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func singUp(name:String,speciallzation:String,email:String,phone:String,password:String,type:String,countyCode:String,device_token:String,profileImg:Data){
        
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
    
    func specializationListApi(){
        let api = Configurator.baseURL + ApiEndPoints.specialist_list
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                let resultDict = response.value as? NSDictionary
                let data = resultDict!["data"] as? [NSDictionary]
                for specialistObj in data! {
                    print(specialistObj)
                    let name = specialistObj["specialist"] as? String
                    self.specialistArr.append(name!)
                    self.dropDownTblView.reloadData()
                }
        }
    }
    
    
    @IBAction func actionSignUp(_ sender: Any) {
//        let img = UIImage(named: "user_pic")
//        if userImg_View.image == img {
//            let alert = UIAlertController(title: "Alert", message: "Please choose profile photo!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if fullName_txtFld.text == ""{
//            let alert = UIAlertController(title: "Alert", message: "Please enter full name!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if select_speciallzationLbl.text == ""{
//            let alert = UIAlertController(title: "Alert", message: "Please select specialization!", preferredStyle: UIAlertController.Style.alert)
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
//        }else if yourPassword_txtFld.text == "" {
//            let alert = UIAlertController(title: "Alert", message: "Please enter password number!", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }else if ((yourPassword_txtFld.text?.count)!)<8 {
//            let alert = UIAlertController(title: "Alert", message: "Password set minimum 8 character!", preferredStyle: UIAlertController.Style.alert)
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
//                self.singUp(name: fullName_txtFld.text!, speciallzation: select_speciallzationLbl.text!, email: emailAddress_txtFld.text!, phone: phoneNumber_txtFld.text!, password: phoneNumber_txtFld.text!, type: "0", countyCode: "+964", device_token: "fIcOhEIJwpE:APA91bGSNKBqmQOr3BnXL5aOLH-iAJ5M5VvbdpQT4FzSVxW8dw7U-3BTT35cm52JfsobjVMJ183cDAqVIEBLMylRg-h5k8U7H_2PoJJoA3t0cqwh-ZMjko1VjfFdk6ifq2cNEt4B35JL", profileImg: imgToUpload)
//            }
//        }
    }
    
    @IBAction func actionSpecializationSelectBtn(_ sender: Any) {
        specialization_dropDownView.backgroundColor = UIColor.white
        phoneNumber_txtFld.isHidden = true
        alradyAcccountView.isHidden = true
        singUpBtn.isHidden = true
        phone_Lbl.isHidden = true
        email_addressLbl.isHidden = true
        password_Lbl.isHidden = true
        confimpassword_lbl.isHidden = true
        emailAddress_txtFld.isHidden = true
        yourPassword_txtFld.isHidden = true
        confirmPassword_txtFld.isHidden = true
        country_codeLbl.isHidden = true
        phoneNumberView.isHidden = true
        specialization_dropDownView.isHidden = false
        specialization_dropDownView.layer.cornerRadius = 5
        specialization_dropDownView.clipsToBounds = true
        specialization_dropDownView.layer.borderColor = UIColor.lightGray.cgColor
        specialization_dropDownView.layer.borderWidth = 0.5
    }
    
    
    @IBAction func actionDoneBtn(_ sender: Any) {
        specialization_dropDownView.isHidden = true
        phoneNumber_txtFld.isHidden = false
        alradyAcccountView.isHidden = false
        singUpBtn.isHidden = false
        phone_Lbl.isHidden = false
        email_addressLbl.isHidden = false
        password_Lbl.isHidden = false
        confimpassword_lbl.isHidden = false
        emailAddress_txtFld.isHidden = false
        yourPassword_txtFld.isHidden = false
        confirmPassword_txtFld.isHidden = false
        country_codeLbl.isHidden = false
        phoneNumberView.isHidden = false
    }
    
    
    @IBAction func actionImgPicker(_ sender: Any) {
        showAlert()
    }
    
    
    @IBAction func actionLoginBtn(_ sender: Any) {
        let loginObj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.navigationController?.pushViewController(loginObj!, animated: true)
    }
    
    
    @IBAction func actionBack_Btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpAsDoctorViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialistArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropDownCell", for: indexPath) as! dropDownCell
        cell.categaryNameLbl.text = specialistArr[indexPath.row]
        if selectedLangCategries.contains(specialistArr[indexPath.row]) {
            cell.selectedImgeView.image  =  UIImage(named:"selectCheckBox")
            cell.checkBoxView.backgroundColor = UIColor.black
        } else {
            cell.selectedImgeView.image  =  UIImage(named:"")
            cell.checkBoxView.backgroundColor = UIColor.clear
        }
        return cell
    }
}

extension SignUpAsDoctorViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? dropDownCell {
            if selectedLangCategries.contains(specialistArr[indexPath.row]){
                let indexToRemove = selectedLangCategries.firstIndex(where: {$0 == specialistArr[indexPath.row]})
                selectedLangCategries.remove(at: indexToRemove ?? 0)
                selectedCell.selectedImgeView.image  =  UIImage(named:"")
                selectedCell.checkBoxView.backgroundColor = UIColor.clear
                let strSelectedCategries = selectedLangCategries.joined(separator: ", ")
                select_speciallzationLbl.text = strSelectedCategries
                select_speciallzationLbl.textColor = UIColor.black
            }
            else{
                selectedLangCategries.append(specialistArr[indexPath.row])
                selectedCell.selectedImgeView.image  =  UIImage(named:"selectCheckBox")
                selectedCell.checkBoxView.backgroundColor = UIColor.black
                let strSelectedCategries = selectedLangCategries.joined(separator: ", ")
                select_speciallzationLbl.text = strSelectedCategries
                select_speciallzationLbl.textColor = UIColor.black
            }
        }
        self.dropDownTblView.reloadData()
    }
}



