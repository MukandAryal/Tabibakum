//
//  PatientProfileUpdateViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class PatientProfileUpdateViewController: UIViewController {

    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var uploadPhoto_Lbl: UIButton!
    
    @IBOutlet weak var fullname_txtFld: UITextField!
    
    @IBOutlet weak var gender_view: UIView!
    
    @IBOutlet weak var gender_textFld: UILabel!
    
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
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
