//
//  doctorSingUpCompleteViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 13/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class doctorSingUpCompleteViewController: UIViewController {
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var next_Btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        next_Btn.layer.cornerRadius = next_Btn.frame.height/2
        next_Btn.clipsToBounds = true
        
    }
    
    @IBAction func actionDoneBtn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "doctorSingUpCompleteViewController") as! doctorSingUpCompleteViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
