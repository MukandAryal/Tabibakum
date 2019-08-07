//
//  SelectLanguageViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 22/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class SelectLanguageViewController: UIViewController {
    
    @IBOutlet weak var chooseLang_Lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionEnglishBtn(_ sender: Any) {
        let selectLang = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        self.navigationController?.pushViewController(selectLang
            , animated:true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func actionUrduBtn(_ sender: Any) {
        
    }
    
}
