//
//  TermsAndConditionsViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 13/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    @IBOutlet weak var decline_Btn: UIButton!
    @IBOutlet weak var accept_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decline_Btn.layer.cornerRadius = 5
        decline_Btn.clipsToBounds = true
        accept_Btn.layer.cornerRadius = 5
        accept_Btn.clipsToBounds = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func actionDeclineBtn(_ sender: Any) {
        decline_Btn.backgroundColor = UiInterFace.appThemeColor
        decline_Btn.setTitleColor(UIColor.white, for: .normal)
        accept_Btn.backgroundColor =  UIColor(red: 240/254, green: 240/254, blue: 240/254, alpha: 1.0)
        accept_Btn.setTitleColor(UIColor.gray, for: .normal)
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func actionAcceptBtn(_ sender: Any) {
        let loginType = UserDefaults.standard.string(forKey: "loginType")
        if loginType == "1" {
            accept_Btn.backgroundColor =  UiInterFace.appThemeColor
            accept_Btn.setTitleColor(UIColor.white, for: .normal)
            decline_Btn.backgroundColor =  UIColor(red: 240/254, green: 240/254, blue: 240/254, alpha: 1.0)
            decline_Btn.setTitleColor(UIColor.gray, for: .normal)
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "doctorSingUpCompleteViewController") as! doctorSingUpCompleteViewController
            self.navigationController?.pushViewController(obj, animated: true)
        }else{
        accept_Btn.backgroundColor =  UiInterFace.appThemeColor
        accept_Btn.setTitleColor(UIColor.white, for: .normal)
        decline_Btn.backgroundColor =  UIColor(red: 240/254, green: 240/254, blue: 240/254, alpha: 1.0)
        decline_Btn.setTitleColor(UIColor.gray, for: .normal)
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "patientSingUpSucessfullyViewController") as! patientSingUpSucessfullyViewController
        self.navigationController?.pushViewController(obj, animated: true)
        }
    }
    
}
