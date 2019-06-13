//
//  patientSingUpSucessfullyViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 13/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class patientSingUpSucessfullyViewController: UIViewController {

    @IBOutlet weak var done_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        done_btn.layer.cornerRadius = done_btn.frame.height/2
        done_btn.clipsToBounds = true
    }
    
    @IBAction func actionDoneBtn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}
