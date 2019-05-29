//
//  DoctorProfileSettingViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class DoctorProfileSettingViewController: UIViewController {
    @IBOutlet weak var info_view: UIView!
    @IBOutlet weak var userImg_VIew: UIImageView!
    @IBOutlet weak var update_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImg_VIew.layer.cornerRadius = userImg_VIew.frame.height/2
        userImg_VIew.clipsToBounds = true
        info_view.layer.cornerRadius = 10
        update_Btn.layer.cornerRadius = update_Btn.frame.height/2
        update_Btn.clipsToBounds = true
        info_view.layer.shadowColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        info_view.layer.shadowOpacity = 1
        info_view.layer.shadowOffset = .zero
        info_view.layer.shadowRadius = 10
    }
    
    @IBAction func actionUpdateBtn(_ sender: Any) {
        let Obj = self.storyboard?.instantiateViewController(withIdentifier: "PatientProfileUpdateViewController") as! PatientProfileUpdateViewController
        self.navigationController?.pushViewController(Obj, animated: true)
    }
    
}
