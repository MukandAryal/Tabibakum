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
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
        popUp_View.layer.cornerRadius = 10
        popUp_View.clipsToBounds = true
        exit_Btn.layer.cornerRadius = 10
        exit_Btn.clipsToBounds = true
        contine_Btn.clipsToBounds = true
        contine_Btn.backgroundColor = UiInterFace.appThemeColor
        exit_Btn.backgroundColor = UiInterFace.tabBackgroundColor
        descripton_Lbl.text = "Are you sure want to exit from the \nprocess ?"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        commonInit()
    }
    
    private func commonInit(){
       
        Bundle.main.loadNibNamed("QuestionNaireExitView", owner: self, options: nil)
        addSubview(popUp_View)
        popUp_View.frame = self.bounds
        popUp_View.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
    }
}
