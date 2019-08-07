//
//  DoctorReviewDescriptionController.swift
//  Tabibakum
//
//  Created by osvinuser on 17/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class DoctorReviewDescriptionController: UIViewController {
    @IBOutlet weak var userProfile_Img: UIImageView!
    @IBOutlet weak var userName_Lbl:
    UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var specialityLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var prescriptionLbl: UILabel!
    @IBOutlet weak var cross_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.layer.cornerRadius = 10
        infoView.clipsToBounds = true
        infoView.layer.borderWidth = 0.5
        infoView.layer.borderColor = UIColor.lightGray.cgColor
        userProfile_Img.layer.cornerRadius = userProfile_Img.frame.height/2
        userProfile_Img.clipsToBounds = true
    }
}
