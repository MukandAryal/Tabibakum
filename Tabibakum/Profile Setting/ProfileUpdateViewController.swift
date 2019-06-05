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

class ProfileUpdateViewController: UIViewController {
    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var uploadPhoto_Lbl: UIButton!
    @IBOutlet weak var fullname_txtFld: UITextField!
    @IBOutlet weak var gender_view: UIView!
    @IBOutlet weak var gender_textFld: UILabel!
    @IBOutlet weak var emailAddress_txtFld: UITextField!
    @IBOutlet weak var education_txtFld: UITextField!
    @IBOutlet weak var speciality_view: UIView!
    @IBOutlet weak var speciality_txtFld: UILabel!
    @IBOutlet weak var experience_VIew: UIView!
    @IBOutlet weak var experience_txtFld: UILabel!
    @IBOutlet weak var dateofbirth_view: UIView!
    @IBOutlet weak var dateofbirth_txtFld: UILabel!
    @IBOutlet weak var facebookLink_txtFld: UITextField!
    @IBOutlet weak var description_txtView: UITextView!
    @IBOutlet weak var submit_btn: UIButton!
    
    var ageArr = ["30","31","32","33","34","35","36","34","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","66","57","58","59","60"]
    var genderArr = ["Male","Female"]
    var expArr = ["1 year","2 year","3 year","4 year","5 year","6 year","7 year","8 year","9 year","10 year"]
    var heightArr = ["4 ft 1 inch","4 ft 2 inch","4 ft 3 inch","4 ft 4 inch","4 ft 5 inch","4 ft 6 inch","4 ft 7 inch"]
    var bloodGroupArr = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]

    let dropDownSingle = DropDown()
    let datePicker = UIDatePicker()
    
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
        
        fullname_txtFld.setLeftPaddingPoints(10)
        emailAddress_txtFld.setLeftPaddingPoints(10)
        education_txtFld.setLeftPaddingPoints(10)
        facebookLink_txtFld.setLeftPaddingPoints(10)
        userProfileApi()
    }
    
    func userProfileApi(){
        let param: [String: String] = [
            "patient_id" : "311"
        ]
        LoadingIndicatorView.show()
        //  let api = Configurator.baseURL + ApiEndPoints.currentbooking
        Alamofire.request("http://18.224.27.255:8000/api/userdata?user_id=311", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for userData in dataDict! {
                    LoadingIndicatorView.hide()
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
//    
//    func showDatePicker(){
//        datePicker.datePickerMode = .date
//        datePicker.maximumDate = Date()
//        
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProfileUpdateViewController.donedatePicker))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: "cancelDatePicker")
//        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
//        self.dateofbirth_txtFld.inputAccessoryView = toolbar
//        self.dateofbirth_txtFld.inputView = datePicker
//    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        self.dateofbirth_txtFld.text = formatter.string(from: datePicker.date)
        //formatter.dateFormat = "MM\dd\yyyy"
       // self.objStep1?.dob = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func configureDropDown(tag:Int) {
        self.dropDownSingle.backgroundColor = UIColor.white
        //self.dropDownMultiple.backgroundColor = UIColor.white
        self.dropDownSingle.dismissMode  = .automatic
        // self.dropDownMultiple.dismissMode  = .onTap
        // dropDownMultiple.selectionBackgroundColor = UIColor(red: 234/255, green: 245/255, blue: 255/255, alpha: 1.0)
        dropDownSingle.selectionBackgroundColor = UIColor(red: 234/255, green: 245/255, blue: 255/255, alpha: 1.0)
        
        if tag == 1 {
            dropDownSingle.anchorView = self.gender_textFld
            dropDownSingle.dataSource = genderArr
            dropDownSingle.width = self.gender_textFld.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 2 {
            dropDownSingle.anchorView = self.speciality_txtFld
            dropDownSingle.dataSource = genderArr
            dropDownSingle.width = self.speciality_txtFld.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 3 {
            dropDownSingle.anchorView = self.experience_txtFld
            dropDownSingle.dataSource = expArr
            dropDownSingle.width = self.experience_txtFld.frame.size.width
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
    
    
    @IBAction func actionGenderBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 1)
        self.dropDownSingle.show()
    }
    @IBAction func actionSpecialityBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 2)
        self.dropDownSingle.show()
    }
    
    @IBAction func actionExperienceBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 3)
        self.dropDownSingle.show()
    }
    
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
