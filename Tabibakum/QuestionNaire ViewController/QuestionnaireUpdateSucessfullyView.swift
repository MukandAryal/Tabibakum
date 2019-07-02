//
//  QuestionnaireUpdateSucessfullyView.swift
//  Tabibakum
//
//  Created by osvinuser on 24/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class QuestionnaireUpdateSucessfullyView: UIView {

    @IBOutlet weak var popUp_View: UIView!
    @IBOutlet weak var descripton_Lbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.popUp_View.layer.cornerRadius = 10
        popUp_View.clipsToBounds = true
        self.clipsToBounds = true
        doneBtn.layer.cornerRadius = 10
        doneBtn.clipsToBounds = true
        doneBtn.backgroundColor = UiInterFace.appThemeColor
        descripton_Lbl.text = "Questionnaire updated sucessfully."
        
        doneBtn.addTarget(self, action: #selector(self.okBtn), for: .touchUpInside)
    }
    
    @objc func okBtn(sender:UIButton) {
        print("Button Clicked")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationlokBtn"), object: nil)
    }
}
