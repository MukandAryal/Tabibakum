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
      self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func actionUrduBtn(_ sender: Any) {
        
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
