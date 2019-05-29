//
//  ProfileUpdateViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 28/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

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
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
