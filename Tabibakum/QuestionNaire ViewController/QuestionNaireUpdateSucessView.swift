//
//  QuestionNaireUpdateSucessView.swift
//  Tabibakum
//
//  Created by osvinuser on 06/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class QuestionNaireUpdateSucessView: UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okBtn.layer.cornerRadius = 8
        okBtn.clipsToBounds = true
        okBtn.backgroundColor = UiInterFace.appThemeColor
    }
}
