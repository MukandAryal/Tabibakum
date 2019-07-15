//
//  ForgotPasswordLinkSentView.swift
//  Tabibakum
//
//  Created by osvinuser on 09/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class ForgotPasswordLinkSentView: UIViewController {
    @IBOutlet weak var title_Lbl: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      okBtn.layer.cornerRadius = 10
      okBtn.clipsToBounds = true
    }
    
}
