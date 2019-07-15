//
//  ScheduleBookingViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 02/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class ScheduleBookingViewController: UIViewController {
    @IBOutlet weak var clickHere_Btn: UIButton!
    @IBOutlet weak var youTubeLink_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clickHere_Btn.layer.cornerRadius = 5
        clickHere_Btn.clipsToBounds = true
        clickHere_Btn.backgroundColor = UiInterFace.appThemeColor
        youTubeLink_Btn.layer.cornerRadius = 5
        youTubeLink_Btn.clipsToBounds = true
        clickHere_Btn.backgroundColor = UiInterFace.appThemeColor
    }
    
 @IBAction func actionClickHereBtn(_ sender: Any) {
    let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorScheduleSetViewController") as! DoctorScheduleSetViewController
    self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func actionYouTubeLinkBtn(_ sender: Any) {
    }
}
