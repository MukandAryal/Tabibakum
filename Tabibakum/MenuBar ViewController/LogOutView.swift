//
//  LogOutView.swift
//  Tabibakum
//
//  Created by osvinuser on 20/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class LogOutView: UIView {
    
    @IBOutlet weak var logout_Btn: UIButton!
    @IBOutlet weak var stayLoggedIn_Btn: UIButton!
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.clipsToBounds = true
        logout_Btn.layer.cornerRadius = 10
        logout_Btn.clipsToBounds = true
        stayLoggedIn_Btn.layer.cornerRadius = 10
        stayLoggedIn_Btn.clipsToBounds = true
        stayLoggedIn_Btn.backgroundColor = UiInterFace.appThemeColor
        logout_Btn.backgroundColor = UiInterFace.tabBackgroundColor
        
        logout_Btn.addTarget(self, action: #selector(self.logoutBtn), for: .touchUpInside)
        
        stayLoggedIn_Btn.addTarget(self, action: #selector(self.stayLoggedInBtn), for: .touchUpInside)
       
    }
    
    @objc func logoutBtn(sender:UIButton) {
        print("Button Clicked")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationlogout"), object: nil)
    }
    
    @objc func stayLoggedInBtn(sender:UIButton) {
        print("Button Clicked")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationstayLoggedIn"), object: nil)
    }
}
