//
//  PatientBookingDoneViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 05/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class PatientBookingDoneViewController: UIViewController {
    @IBOutlet weak var yourBooking_Lbl: UILabel!
    @IBOutlet weak var timeSlot_Lbl: UILabel!
    @IBOutlet weak var done_Btn: UIButton!
    var dateString = String()
    var timeString = String()
    override func viewDidLoad() {
        super.viewDidLoad()
     done_Btn.layer.cornerRadius = done_Btn.frame.height/2
     done_Btn.clipsToBounds = true
     yourBooking_Lbl.text = "Your bookings is confirmed by" + " " + dateString
        timeSlot_Lbl.text = "Time Slot : " + " " + timeString
    }
    
    @IBAction func actionDoneBtn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
      self.navigationController?.pushViewController(obj, animated: true)
    }
}
