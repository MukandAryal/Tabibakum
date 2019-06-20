//
//  BaseClassViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 20/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class BaseClassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
 func questionNaireProcessExit(){
    let popUpView = QuestionNaireExitView()
        popUpView.frame = CGRect(x: 10, y: 20, width: view.frame.width, height: 225)
        popUpView.backgroundColor = UIColor.white
        self.view.addSubview(popUpView)
    }
    
 }
