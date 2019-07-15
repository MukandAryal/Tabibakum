//
//  QuestionNaireBackView.swift
//  Tabibakum
//
//  Created by osvinuser on 06/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class QuestionNaireBackView: UIViewController {

    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var titleLabal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exitBtn.layer.cornerRadius = 8
        exitBtn.clipsToBounds = true
        continueBtn.layer.cornerRadius = 8
        continueBtn.clipsToBounds = true
        continueBtn.backgroundColor = UiInterFace.appThemeColor
        exitBtn.backgroundColor = UiInterFace.tabBackgroundColor
    }
}
