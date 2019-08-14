//
//  PatientProfileUpdateViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import DropDown

class PatientProfileUpdateViewController: BaseClassViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var uploadPhoto_Lbl: UIButton!
    @IBOutlet weak var fullname_txtFld: UITextField!
    @IBOutlet weak var gender_view: UIView!
    @IBOutlet weak var gender_textFld: UITextField!
    @IBOutlet weak var age_Lbl: UITextField!
    @IBOutlet weak var emailAddress_txtFld: UITextField!
    @IBOutlet weak var age_view: UIView!
    @IBOutlet weak var weight_view: UIView!
    @IBOutlet weak var Height_VIew: UIView!
    @IBOutlet weak var dateofbirth_view: UIView!
    @IBOutlet weak var dateofbirth_txtFld: UITextField!
    @IBOutlet weak var description_txtView: UITextView!
    @IBOutlet weak var bloodGroup_view: UIView!
    @IBOutlet weak var update_btn: UIButton!
    @IBOutlet weak var facebookLink_txtFld: UITextField!
    @IBOutlet weak var address_txtFld: UITextField!
    @IBOutlet weak var weight_Lbl: UITextField!
    @IBOutlet weak var height_Lbl: UITextField!
    @IBOutlet weak var bloodGroup_Lbl: UITextField!
    @IBOutlet weak var back_Btn: UIBarButtonItem!
    let datePicker = UIDatePicker()
    var ageArr = [String]()
    var weightArr = [String]()
    var genderArr = ["Male","Female"]
    var bloodGroupArr = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]
    var heightArr = ["4 ft 1 inch","4 ft 2 inch","4 ft 3 inch","4 ft 4 inch","4 ft 5 inch","4 ft 6 inch","4 ft 7 inch","4 ft 8 inch","4 ft 9 inch","4 ft 10 inch","4 ft 11 inch","4 ft 12 inch","5 ft 1 inch","5 ft 2 inch","5 ft 3 inch","5 ft 4 inch","5 ft 5 inch","5 ft 6 inch","5 ft 7 inch","5 ft 8 inch","5 ft 9 inch","5 ft 1o inch","5 ft 11 inch","5 ft 12 inch","6 ft 1 inch","6 ft 2 inch","6 ft 3 inch","6 ft 4 inch","6 ft 5 inch","6 ft 6 inch","6 ft 7 inch","6 ft 5 inch","6 ft 9 inch","6 ft 10 inch","6 ft 11 inch","6 ft 12 inch"]
    let dropDownSingle = DropDown()
    let imagePicker = UIImagePickerController()
    var imgToUpload = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLoop()
        customUiDesign()
    }
    
    func customUiDesign(){
        profile_imgView.layer.cornerRadius = profile_imgView.frame.height/2
        profile_imgView.clipsToBounds = true
        
        fullname_txtFld.layer.borderWidth = 0.5
        fullname_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        fullname_txtFld.layer.cornerRadius = 5
        fullname_txtFld.clipsToBounds = true
        
        gender_view.layer.borderWidth = 0.5
        gender_view.layer.borderColor = UIColor.lightGray.cgColor
        gender_view.layer.cornerRadius = 5
        gender_view.clipsToBounds = true
        
        age_view.layer.borderWidth = 0.5
        age_view.layer.borderColor = UIColor.lightGray.cgColor
        age_view.layer.cornerRadius = 5
        age_view.clipsToBounds = true
        
        emailAddress_txtFld.layer.borderWidth = 0.5
        emailAddress_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        emailAddress_txtFld.layer.cornerRadius = 5
        emailAddress_txtFld.clipsToBounds = true
        
        weight_view.layer.borderWidth = 0.5
        weight_view.layer.borderColor = UIColor.lightGray.cgColor
        weight_view.layer.cornerRadius = 5
        weight_view.clipsToBounds = true
        
        Height_VIew.layer.borderWidth = 0.5
        Height_VIew.layer.borderColor = UIColor.lightGray.cgColor
        Height_VIew.layer.cornerRadius = 5
        Height_VIew.clipsToBounds = true
        
        bloodGroup_view.layer.borderWidth = 0.5
        bloodGroup_view.layer.borderColor = UIColor.lightGray.cgColor
        bloodGroup_view.layer.cornerRadius = 5
        bloodGroup_view.clipsToBounds = true
        
        dateofbirth_view.layer.borderWidth = 0.5
        dateofbirth_view.layer.borderColor = UIColor.lightGray.cgColor
        dateofbirth_view.layer.cornerRadius = 5
        dateofbirth_view.clipsToBounds = true
        
        facebookLink_txtFld.layer.borderWidth = 0.5
        facebookLink_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        facebookLink_txtFld.layer.cornerRadius = 5
        facebookLink_txtFld.clipsToBounds = true
        
        address_txtFld.layer.borderWidth = 0.5
        address_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        address_txtFld.layer.cornerRadius = 5
        address_txtFld.clipsToBounds = true
        
        description_txtView.layer.borderWidth = 0.5
        description_txtView.layer.borderColor = UIColor.lightGray.cgColor
        description_txtView.layer.cornerRadius = 5
        description_txtView.clipsToBounds = true
        
        update_btn.layer.cornerRadius = update_btn.frame.height/2
        update_btn.clipsToBounds = true
        
        uploadPhoto_Lbl.layer.cornerRadius = uploadPhoto_Lbl.frame.height/2
        uploadPhoto_Lbl.clipsToBounds = true
        imagePicker.delegate = self
        
        fullname_txtFld.setLeftPaddingPoints(10)
        emailAddress_txtFld.setLeftPaddingPoints(10)
        facebookLink_txtFld.setLeftPaddingPoints(10)
        address_txtFld.setLeftPaddingPoints(10)
        age_Lbl.setLeftPaddingPoints(10)
        gender_textFld.setLeftPaddingPoints(10)
        weight_Lbl.setLeftPaddingPoints(10)
        height_Lbl.setLeftPaddingPoints(10)
        bloodGroup_Lbl.setLeftPaddingPoints(10)
        dateofbirth_txtFld.setLeftPaddingPoints(10)
        userProfileApi()
        showDatePicker()
    }
    
    func countLoop(){
        for age in 16...80 {
            print(age)
            ageArr.append(age.description)
        }
        
        for weight in 30...149 {
            print(weight)
            weightArr.append(weight.description + " " + "kg")
        }
    }
    
    func userProfileApi(){
        self.showCustomProgress()
        let useid = UserDefaults.standard.integer(forKey: "userId")
        let api = Configurator.baseURL + ApiEndPoints.userdata + "?user_id=\(useid)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
              //  print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for userData in dataDict! {
                    self.stopProgress()
                    self.fullname_txtFld.text = userData["name"] as? String
                    let img =  userData["avatar"] as? String
                    //imgToUpload = userData["avatar"] as? String
                    let imageStr = Configurator.imageBaseUrl + img!
                    self.profile_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
                    self.emailAddress_txtFld.text = userData["email"] as? String
                    self.dateofbirth_txtFld.text = userData["date_of_birth"] as? String
                    self.gender_textFld.text = userData["gender"] as? String
                    self.weight_Lbl.text = userData["weight"] as? String
                    self.height_Lbl.text = userData["height"] as? String
                    self.description_txtView.text = userData["description"] as? String
                    self.facebookLink_txtFld.text = userData["facebook"] as? String
                    self.address_txtFld.text = userData["address"] as? String
                }
        }
    }
    
    func profileUpdateApi(name:String,age:String,gender:String,email:String,weight:String,height:String,bloodType:String,address:String,dateOfBirth:String,facebookLink:String,token:String,description:String,profileImg:Data){
        
        self.showCustomProgress()
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(name.data(using: String.Encoding.utf8)!, withName: "name")
                multipartFormData.append(age.data(using: String.Encoding.utf8)!, withName: "age")
                multipartFormData.append(gender.data(using: String.Encoding.utf8)!, withName: "gender")
                multipartFormData.append(email.data(using: String.Encoding.utf8)!, withName: "email")
                multipartFormData.append(weight.data(using: String.Encoding.utf8)!, withName: "weight")
                multipartFormData.append(height.data(using: String.Encoding.utf8)!, withName: "height")
                multipartFormData.append(bloodType.data(using: String.Encoding.utf8)!, withName: "bloodtype")
                multipartFormData.append(address.data(using: String.Encoding.utf8)!, withName: "address")
                multipartFormData.append(dateOfBirth.data(using: String.Encoding.utf8)!, withName: "date_of_birth")
                multipartFormData.append(facebookLink.data(using: String.Encoding.utf8)!, withName: "facebook")
                multipartFormData.append(description.data(using: String.Encoding.utf8)!, withName: "description")
                multipartFormData.append(token.data(using: String.Encoding.utf8)!, withName: "token")
                
                if let imgToUpload = self.profile_imgView.image!.jpegData(compressionQuality: 0.2) {
                    multipartFormData.append(imgToUpload, withName: "avatar", fileName: "\(String(NSDate().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")).jpeg", mimeType: "image/jpeg")
                }
                
                print(multipartFormData)
        },
            to:"\(Configurator.baseURL)\(ApiEndPoints.profileUpdate)",
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                      //  print(response)
                        self.stopProgress()
                        let resultDict = response.value as? [String:AnyObject]
                        if let sucessStr = resultDict!["success"] as? Bool{
                            print(sucessStr)
                            if sucessStr{
                                self.showUpdateCustomDialog()
                            }else{
                                let alert = UIAlertController(title: "Alert", message: "Sumthing wrong please try again!", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        }
                        .uploadProgress { progress in // main queue by default
                          ///  print("Upload Progress: \(progress.fractionCompleted)")
                    }
                    return
                case .failure(let encodingError):
                    debugPrint(encodingError)
                    self.stopProgress()
                }
        })
    }
    
    func configureDropDown(tag:Int) {
        self.dropDownSingle.backgroundColor = UIColor.white
        //self.dropDownMultiple.backgroundColor = UIColor.white
        self.dropDownSingle.dismissMode  = .automatic
        // self.dropDownMultiple.dismissMode  = .onTap
        // dropDownMultiple.selectionBackgroundColor = UIColor(red: 234/255, green: 245/255, blue: 255/255, alpha: 1.0)
        dropDownSingle.selectionBackgroundColor = UIColor(red: 234/255, green: 245/255, blue: 255/255, alpha: 1.0)
        
        if tag == 1 {
            dropDownSingle.anchorView = self.age_Lbl
            dropDownSingle.dataSource = ageArr
            dropDownSingle.width = self.age_view.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 2 {
            dropDownSingle.anchorView = self.gender_textFld
            dropDownSingle.dataSource = genderArr
            dropDownSingle.width = self.gender_view.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 3 {
            dropDownSingle.anchorView = self.weight_Lbl
            dropDownSingle.dataSource = weightArr
            dropDownSingle.width = self.weight_view.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 4 {
            dropDownSingle.anchorView = self.height_Lbl
            dropDownSingle.dataSource = heightArr
            dropDownSingle.width = self.Height_VIew.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 5 {
            dropDownSingle.anchorView = self.bloodGroup_Lbl
            dropDownSingle.dataSource = bloodGroupArr
            dropDownSingle.width = self.bloodGroup_view.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }
        dropDownSingle.selectionAction = { [unowned self] (index: Int, item: String) in
            if tag == 1 {
                self.age_Lbl.text = item
                self.age_Lbl.textColor = .black
            } else if tag == 2 {
                self.gender_textFld.text = item
                self.gender_textFld.textColor = .black
            } else if tag == 3 {
                self.weight_Lbl.text = item
                self.weight_Lbl.textColor = .black
            } else if tag == 4 {
                self.height_Lbl.text = item
                self.height_Lbl.textColor = .black
            }else if tag == 5 {
                self.bloodGroup_Lbl.text = item
                self.bloodGroup_Lbl.textColor = .black
            }
        }
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ProfileUpdateViewController.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: "cancelDatePicker")
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        self.dateofbirth_txtFld.inputAccessoryView = toolbar
        self.dateofbirth_txtFld.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        self.dateofbirth_txtFld.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func cancelDatePicker(){
        self.view.endEditing(true)
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
        profile_imgView.image = selectedImage
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            imgToUpload = imageData
        }
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func showUpdateCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireUpdateSucessView") as? QuestionNaireUpdateSucessView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.titleLable.text = "Profile Update Sucessfully."
        exitVc!.okBtn.addTargetClosure { _ in
            popup.dismiss()
            self.profileUpdateDone()
        }
        
        present(popup, animated: animated, completion: nil)
    }
    
    func profileUpdateDone(){
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func actionProfileImgBtn(_ sender: Any) {
        showAlert()
    }
    
    
    @IBAction func actionAgeBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 1)
        self.dropDownSingle.show()
    }
    
    @IBAction func actionGenderBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 2)
        self.dropDownSingle.show()
    }
    
    @IBAction func actionWeightBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 3)
        self.dropDownSingle.show()
    }
    
    @IBAction func actionHeightBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 4)
        self.dropDownSingle.show()
    }
    
    @IBAction func actionBloodGroupBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 5)
        self.dropDownSingle.show()
    }
    @IBAction func actionProfileBtn(_ sender: Any) {
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        let img = UIImage(named: "user_pic")
        if profile_imgView.image == img {
            let alert = UIAlertController(title: "Alert", message: "Please choose profile photo!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if fullname_txtFld.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please enter full name!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if emailAddress_txtFld.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Please enter email Id!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if emailAddress_txtFld.text != nil {
            if !isValidEmail(testStr: emailAddress_txtFld.text!)  {
                let alert = UIAlertController(title: "Alert", message: "Please enter valid email id!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                self.profileUpdateApi(name: fullname_txtFld.text!, age: age_Lbl.text!, gender: gender_textFld.text!, email: emailAddress_txtFld.text!, weight: weight_Lbl.text!, height: height_Lbl.text!, bloodType: bloodGroup_Lbl.text!, address: address_txtFld.text!, dateOfBirth: dateofbirth_txtFld.text!, facebookLink: facebookLink_txtFld.text!, token: loginToken!, description: description_txtView.text, profileImg: imgToUpload)
            }
        }
    }
    
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
