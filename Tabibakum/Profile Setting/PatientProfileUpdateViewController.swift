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

class PatientProfileUpdateViewController: UIViewController {
    
    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var uploadPhoto_Lbl: UIButton!
    @IBOutlet weak var fullname_txtFld: UITextField!
    @IBOutlet weak var gender_view: UIView!
    @IBOutlet weak var gender_textFld: UILabel!
    @IBOutlet weak var age_Lbl: UILabel!
    @IBOutlet weak var emailAddress_txtFld: UITextField!
    @IBOutlet weak var age_view: UIView!
    @IBOutlet weak var weight_view: UIView!
    @IBOutlet weak var Height_VIew: UIView!
    @IBOutlet weak var dateofbirth_view: UIView!
    @IBOutlet weak var dateofbirth_txtFld: UILabel!
    @IBOutlet weak var description_txtView: UITextView!
    @IBOutlet weak var bloodGroup_view: UIView!
    @IBOutlet weak var update_btn: UIButton!
    @IBOutlet weak var facebookLink_txtFld: UITextField!
    @IBOutlet weak var address_txtFld: UITextField!
    @IBOutlet weak var weight_Lbl: UILabel!
    @IBOutlet weak var height_Lbl: UILabel!
    @IBOutlet weak var bloodGroup_Lbl: UILabel!
    
    var ageArr = ["30","31","32","33","34","35","36","34","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","66","57","58","59","60"]
    var genderArr = ["Male","Female"]
    var weightArr = ["1","2","3","4","5","6","7","8","9","10"]
    var heightArr = ["4 ft 1 inch","4 ft 2 inch","4 ft 3 inch","4 ft 4 inch","4 ft 5 inch","4 ft 6 inch","4 ft 7 inch"]
    var bloodGroupArr = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]
    
    
     let dropDownSingle = DropDown()
    
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
        
        fullname_txtFld.setLeftPaddingPoints(10)
        emailAddress_txtFld.setLeftPaddingPoints(10)
        facebookLink_txtFld.setLeftPaddingPoints(10)
        address_txtFld.setLeftPaddingPoints(10)
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
                    self.fullname_txtFld.text = userData["name"] as? String
                    let img =  userData["avatar"] as? String
                    let imageStr = Configurator.imageBaseUrl + img!
                    self.profile_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
                    self.emailAddress_txtFld.text = userData["email"] as? String
                    self.dateofbirth_txtFld.text = userData["date_of_birth"] as? String
                    self.gender_textFld.text = userData["gender"] as? String
                    self.weight_Lbl.text = userData["weight"] as? String
                    self.height_Lbl.text = userData["height"] as? String
                    self.description_txtView.text = userData["description"] as? String
                }
        }
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
            dropDownSingle.width = self.age_Lbl.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 2 {
            dropDownSingle.anchorView = self.gender_textFld
            dropDownSingle.dataSource = genderArr
            dropDownSingle.width = self.gender_textFld.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 3 {
            dropDownSingle.anchorView = self.weight_Lbl
            dropDownSingle.dataSource = weightArr
            dropDownSingle.width = self.weight_Lbl.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 4 {
            dropDownSingle.anchorView = self.height_Lbl
            dropDownSingle.dataSource = heightArr
            dropDownSingle.width = self.height_Lbl.frame.size.width
            dropDownSingle.selectionBackgroundColor = UIColor.clear
        }else if tag == 5 {
            dropDownSingle.anchorView = self.bloodGroup_Lbl
            dropDownSingle.dataSource = bloodGroupArr
            dropDownSingle.width = self.bloodGroup_Lbl.frame.size.width
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
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
