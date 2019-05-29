//
//  ProfileSettingViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 28/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class ProfileSettingViewController: UIViewController {
    @IBOutlet weak var profile_ImgView: UIImageView!
    @IBOutlet weak var info_view: UIView!
    @IBOutlet weak var update_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile_ImgView.layer.cornerRadius = profile_ImgView.frame.height/2
        profile_ImgView.clipsToBounds = true
        info_view.layer.cornerRadius = 10
        update_Btn.layer.cornerRadius = update_Btn.frame.height/2
        update_Btn.clipsToBounds = true
        info_view.layer.shadowColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        info_view.layer.shadowOpacity = 1
        info_view.layer.shadowOffset = .zero
        info_view.layer.shadowRadius = 10
    }
    
    @IBAction func actionUpdateBtn(_ sender: Any) {
        let profileUpdate = self.storyboard?.instantiateViewController(withIdentifier: "ProfileUpdateViewController") as! ProfileUpdateViewController
        self.navigationController?.pushViewController(profileUpdate, animated: true)
    }
    
}
