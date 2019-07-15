//
//  patientProfileHeaderView.swift
//  Tabibakum
//
//  Created by osvinuser on 08/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class patientProfileHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var Userprofile_imgView: UIImageView!
    @IBOutlet weak var user_NameLbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var height_View: UIView!
    @IBOutlet weak var bloodGroup_View: UIView!
    @IBOutlet weak var growth_View: UIView!
    @IBOutlet weak var age_View: UIView!
    @IBOutlet weak var userInfo_View: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Userprofile_imgView.layer.cornerRadius = Userprofile_imgView.frame.height/2
        Userprofile_imgView.clipsToBounds = true
        height_View.layer.cornerRadius = 5
        height_View.clipsToBounds = true
        bloodGroup_View.layer.cornerRadius = 5
        bloodGroup_View.clipsToBounds = true
        growth_View.layer.cornerRadius = 5
        growth_View.clipsToBounds = true
        age_View.layer.cornerRadius = 5
        age_View.clipsToBounds = true
        userInfo_View.layer.cornerRadius = 5
        userInfo_View.clipsToBounds = true
        userInfo_View.layer.borderWidth = 0.5
        userInfo_View.layer.borderColor = UIColor.lightGray.cgColor
    }
}
