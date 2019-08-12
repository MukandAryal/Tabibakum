//
//  ProfileUpdateViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 28/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class ProfileUpdateViewController: BaseClassViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var uploadPhoto_Lbl: UIButton!
    @IBOutlet weak var fullname_txtFld: UITextField!
    @IBOutlet weak var gender_view: UIView!
    @IBOutlet weak var gender_textFld: UITextField!
    @IBOutlet weak var emailAddress_txtFld: UITextField!
    @IBOutlet weak var education_txtFld: UITextField!
    @IBOutlet weak var speciality_view: UIView!
    @IBOutlet weak var speciality_txtFld: UITextField!
    @IBOutlet weak var experience_VIew: UIView!
    @IBOutlet weak var experience_txtFld: UITextField!
    @IBOutlet weak var dateofbirth_view: UIView!
    @IBOutlet weak var dateofbirth_txtFld: UITextField!
    @IBOutlet weak var facebookLink_txtFld: UITextField!
    @IBOutlet weak var description_txtView: UITextView!
    @IBOutlet weak var submit_btn: UIButton!
    @IBOutlet weak var specialization_dropDownView: UIView!
    @IBOutlet weak var dropDownTblView: UITableView!
    
    var genderArr = ["Male","Female"]
    
    var expArr = ["0 year","1 year","2 year","3 year","4 year","5 year","6 year","7 year","8 year","9 year","10 year","11 year","12 year","13 year","14 year","15 year","16 year","17 year","18 year","19 year","20 year","21 year","22 year","23 year","24 year","24 year","26 year","27 year","28 year","29 year","30 year","31 year","32 year","33 year","34 year","35 year","36 year","37 year","38 year","39 year"]
    
    let dropDownSingle = DropDown()
    let dropDownMultiple = DropDown()
    let datePicker = UIDatePicker()
    let imagePicker = UIImagePickerController()
    var imgToUpload = Data()
    var specialistArr = [String]()
    var selectedLangCategries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        education_txtFld.layer.borderWidth = 0.5
        education_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        education_txtFld.layer.cornerRadius = 5
        education_txtFld.clipsToBounds = true
        
        emailAddress_txtFld.layer.borderWidth = 0.5
        emailAddress_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        emailAddress_txtFld.layer.cornerRadius = 5
        emailAddress_txtFld.clipsToBounds = true
        
        speciality_view.layer.borderWidth = 0.5
        speciality_view.layer.borderColor = UIColor.lightGray.cgColor
        speciality_view.layer.cornerRadius = 5
        speciality_view.clipsToBounds = true
        
        experience_VIew.layer.borderWidth = 0.5
        experience_VIew.layer.borderColor = UIColor.lightGray.cgColor
        experience_VIew.layer.cornerRadius = 5
        experience_VIew.clipsToBounds = true
        
        dateofbirth_view.layer.borderWidth = 0.5
        dateofbirth_view.layer.borderColor = UIColor.lightGray.cgColor
        dateofbirth_view.layer.cornerRadius = 5
        dateofbirth_view.clipsToBounds = true
        
        
        facebookLink_txtFld.layer.borderWidth = 0.5
        facebookLink_txtFld.layer.borderColor = UIColor.lightGray.cgColor
        facebookLink_txtFld.layer.cornerRadius = 5
        facebookLink_txtFld.clipsToBounds = true
        
        description_txtView.layer.borderWidth = 0.5
        description_txtView.layer.borderColor = UIColor.lightGray.cgColor
        description_txtView.layer.cornerRadius = 5
        description_txtView.clipsToBounds = true
        
        submit_btn.layer.cornerRadius = submit_btn.frame.height/2
        submit_btn.clipsToBounds = true
        
        uploadPhoto_Lbl.layer.cornerRadius = uploadPhoto_Lbl.frame.height/2
        uploadPhoto_Lbl.clipsToBounds = true
        
        specialization_dropDownView.isHidden = true
        specialization_dropDownView.layer.cornerRadius = 10
        specialization_dropDownView.clipsToBounds = true
        specialization_dropDownView.isHidden = true
        
        fullname_txtFld.setLeftPaddingPoints(10)
        emailAddress_txtFld.setLeftPaddingPoints(10)
        education_txtFld.setLeftPaddingPoints(10)
        facebookLink_txtFld.setLeftPaddingPoints(10)
        gender_textFld.setLeftPaddingPoints(10)
        dateofbirth_txtFld.setLeftPaddingPoints(10)
        speciality_txtFld.setLeftPaddingPoints(10)
        experience_txtFld.setLeftPaddingPoints(10)
        imagePicker.delegate = self
        userProfileApi()
        showDatePicker()
        specializationListApi()
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
                    let img =  userData["avatar"] as? String
                    let imageStr = Configurator.imageBaseUrl + img!
                    self.profile_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
                    self.speciality_txtFld.text = userData["specialist"] as? String
                    self.fullname_txtFld.text = userData["name"] as? String
                    self.education_txtFld.text = userData["education"] as? String
                    self.emailAddress_txtFld.text = userData["email"] as? String
                    self.experience_txtFld.text = userData["experience"] as? String
                    self.gender_textFld.text = userData["gender"] as? String
                    self.dateofbirth_txtFld.text = userData["date_of_birth"] as? String
                    self.description_txtView.text = userData["description"] as? String
                    self.facebookLink_txtFld.text = userData["facebook"] as? String
                    self.education_txtFld.text = userData["education"] as? String
                }
        }
    }
    
    func specializationListApi(){
        let api = Configurator.baseURL + ApiEndPoints.specialist_list
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
              //  print(response)
                let resultDict = response.value as? NSDictionary
                let data = resultDict!["data"] as? [NSDictionary]
                for specialistObj in data! {
                    print(specialistObj)
                    let name = specialistObj["specialist"] as? String
                    self.specialistArr.append(name!)
                    
                }
                self.dropDownTblView.reloadData()
        }
    }
    
    func profileUpdateApi(device_token:String,name:String,email:String,gender:String,education:String,specialist:String,experience:String,dateOfBirth:String,facebookLink:String,description:String,profileImg:Data){
        
        self.showCustomProgress()
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(device_token.data(using: String.Encoding.utf8)!, withName: "token")
                multipartFormData.append(name.data(using: String.Encoding.utf8)!, withName: "name")
                multipartFormData.append(gender.data(using: String.Encoding.utf8)!, withName: "gender")
                multipartFormData.append(email.data(using: String.Encoding.utf8)!, withName: "email")
                multipartFormData.append(education.data(using: String.Encoding.utf8)!, withName: "education")
                multipartFormData.append(specialist.data(using: String.Encoding.utf8)!, withName: "specialist")
                multipartFormData.append(experience.data(using: String.Encoding.utf8)!, withName: "experience")
                multipartFormData.append(dateOfBirth.data(using: String.Encoding.utf8)!, withName: "date_of_birth")
                multipartFormData.append(facebookLink.data(using: String.Encoding.utf8)!, withName: "facebook")
                multipartFormData.append(description.data(using: String.Encoding.utf8)!, withName: "description")
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
                        var resultDict = response.value as? [String:AnyObject]
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
                           // print("Upload Progress: \(progress.fractionCompleted)")
                    }
                    return
                case .failure(let encodingError):
                    self.stopProgress()
                    debugPrint(encodingError)
                }
        })
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
    
    func configureDropDown(tag:Int) {
        self.dropDownSingle.backgroundColor = UIColor.white
        self.dropDownMultiple.backgroundColor = UIColor.white
        self.dropDownSingle.dismissMode  = .automatic
        self.dropDownMultiple.dismissMode  = .onTap
        dropDownMultiple.selectionBackgroundColor = UIColor(red: 234/255, green: 245/255, blue: 255/255, alpha: 1.0)
        dropDownSingle.selectionBackgroundColor = UIColor(red: 234/255, green: 245/255, blue: 255/255, alpha: 1.0)
        
        if tag == 1 {
            dropDownSingle.anchorView = self.gender_textFld
            dropDownSingle.dataSource = genderArr
            dropDownSingle.width = self.gender_view.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 2 {
            dropDownSingle.anchorView = self.speciality_txtFld
            dropDownSingle.dataSource = specialistArr
            dropDownSingle.width = self.speciality_view.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 3 {
            dropDownSingle.anchorView = self.experience_txtFld
            dropDownSingle.dataSource = expArr
            dropDownSingle.width = self.experience_VIew.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }
        dropDownSingle.selectionAction = { [unowned self] (index: Int, item: String) in
            if tag == 1 {
                self.gender_textFld.text = item
                self.gender_textFld.textColor = .black
            } else if tag == 2 {
                self.speciality_txtFld.text = item
                self.speciality_txtFld.textColor = .black
            } else if tag == 3 {
                self.experience_txtFld.text = item
                self.experience_txtFld.textColor = .black
            }
        }
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
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorHomeViewController") as! DoctorHomeViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    
    @IBAction func actionUpdateProfileImgBtn(_ sender: Any) {
        showAlert()
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
                profileUpdateApi(device_token: loginToken!, name: fullname_txtFld.text!, email: emailAddress_txtFld.text!, gender: gender_textFld.text!, education: education_txtFld.text!, specialist: speciality_txtFld.text!, experience: experience_txtFld.text!, dateOfBirth: dateofbirth_txtFld.text!, facebookLink: facebookLink_txtFld.text!, description: description_txtView.text!, profileImg: imgToUpload)
            }
        }
    }
    @IBAction func actiondoneBtn(_ sender: Any) {
        specialization_dropDownView.backgroundColor = UIColor.white
        experience_VIew.isHidden = false
        description_txtView.isHidden = false
        submit_btn.isHidden = false
        specialization_dropDownView.isHidden = true
        specialization_dropDownView.layer.cornerRadius = 5
        specialization_dropDownView.clipsToBounds = false
        specialization_dropDownView.layer.borderColor = UIColor.lightGray.cgColor
        specialization_dropDownView.layer.borderWidth = 0.5
    }
    
    @IBAction func actionGenderBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 1)
        self.dropDownSingle.show()
    }
    
    @IBAction func actionSpecialityBtn(_ sender: Any) {
        specialization_dropDownView.backgroundColor = UIColor.white
        experience_VIew.isHidden = true
        description_txtView.isHidden = true
        submit_btn.isHidden = true
        specialization_dropDownView.isHidden = false
        specialization_dropDownView.layer.cornerRadius = 5
        specialization_dropDownView.clipsToBounds = true
        specialization_dropDownView.layer.borderColor = UIColor.lightGray.cgColor
        specialization_dropDownView.layer.borderWidth = 0.5
    }
    
    @IBAction func actionExperienceBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 3)
        self.dropDownSingle.show()
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionDoneBtn(_ sender: Any) {
    }
    
}

extension ProfileUpdateViewController : UITableViewDataSource{
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

extension ProfileUpdateViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? dropDownCell {
            if selectedLangCategries.contains(specialistArr[indexPath.row]){
                let indexToRemove = selectedLangCategries.firstIndex(where: {$0 == specialistArr[indexPath.row]})
                selectedLangCategries.remove(at: indexToRemove ?? 0)
                selectedCell.selectedImgeView.image  =  UIImage(named:"")
                selectedCell.checkBoxView.backgroundColor = UIColor.clear
                let strSelectedCategries = selectedLangCategries.joined(separator: ", ")
                speciality_txtFld.text = strSelectedCategries
                speciality_txtFld.textColor = UIColor.black
            }
            else{
                selectedLangCategries.append(specialistArr[indexPath.row])
                selectedCell.selectedImgeView.image  =  UIImage(named:"selectCheckBox")
                selectedCell.checkBoxView.backgroundColor = UIColor.black
                let strSelectedCategries = selectedLangCategries.joined(separator: ", ")
                speciality_txtFld.text = strSelectedCategries
                speciality_txtFld.textColor = UIColor.black
            }
        }
        self.dropDownTblView.reloadData()
    }
}

