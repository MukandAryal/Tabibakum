//
//  QuestionNaireExitView.swift
//  Tabibakum
//
//  Created by osvinuser on 20/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class QuestionNaireExitView: UIView {
    @IBOutlet weak var popUp_View: UIView!
    @IBOutlet weak var descripton_Lbl: UILabel!
    @IBOutlet weak var exit_Btn: UIButton!
    @IBOutlet weak var contine_Btn: UIButton!
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.popUp_View.layer.cornerRadius = 10
        popUp_View.clipsToBounds = true
        self.clipsToBounds = true
        exit_Btn.layer.cornerRadius = 10
        exit_Btn.clipsToBounds = true
        contine_Btn.layer.cornerRadius = 10
        contine_Btn.clipsToBounds = true
        contine_Btn.backgroundColor = UiInterFace.appThemeColor
        exit_Btn.backgroundColor = UiInterFace.tabBackgroundColor
        descripton_Lbl.text = "Are you sure want to exit from the \nprocess ?"
        
        exit_Btn.addTarget(self, action: #selector(self.exitBtn), for: .touchUpInside)
        
        contine_Btn.addTarget(self, action: #selector(self.contineBtn), for: .touchUpInside)
    }
    
    @objc func exitBtn(sender:UIButton) {
        print("Button Clicked")
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationlExit"), object: nil)
    }
    
    @objc func contineBtn(sender:UIButton) {
        print("Button Clicked")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationContineBtn"), object: nil)
    }
}
