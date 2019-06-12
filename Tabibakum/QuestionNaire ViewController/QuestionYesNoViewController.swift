//
//  QuestionYesNoViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 11/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class QuestionYesNoViewController: UIViewController {
    @IBOutlet weak var yes_Btn: UIButton!
    @IBOutlet weak var no_Btn: UIButton!
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var questionNaire_Lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yes_Btn.layer.cornerRadius = 5
        yes_Btn.clipsToBounds = true
        no_Btn.layer.cornerRadius = 5
        no_Btn.clipsToBounds = true
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        questionNaireApi()
    }
    
    func questionNaireApi(){
        LoadingIndicatorView.show()
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let api = Configurator.baseURL + ApiEndPoints.patientquestion + "?id=\(userId)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                LoadingIndicatorView.hide()
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let type = specialistObj["type"] as? String
                    if type == "yesno"{
                        self.questionNaire_Lbl.text = specialistObj["question"] as? String
                        }
                    }
              }
        }
    
    @IBAction func actionBackBtn(_ sender: Any) {
     self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionYesBtn(_ sender: Any) {
       yes_Btn.backgroundColor =  UIColor(red: 61/254, green: 151/254, blue: 49/254, alpha: 1.0)
       yes_Btn.setTitleColor(UIColor.white, for: .normal)
       no_Btn.backgroundColor =  UIColor(red: 240/254, green: 240/254, blue: 240/254, alpha: 1.0)
       no_Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    @IBAction func actionNoBtn(_ sender: Any) {
       no_Btn.backgroundColor = UIColor(red: 61/254, green: 151/254, blue: 49/254, alpha: 1.0)
       no_Btn.setTitleColor(UIColor.white, for: .normal)
       yes_Btn.backgroundColor =  UIColor(red: 240/254, green: 240/254, blue: 240/254, alpha: 1.0)
       yes_Btn.setTitleColor(UIColor.gray, for: .normal)
    }
    @IBAction func actionSkipBtn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireTextViewController") as? QuestionNaireTextViewController
        self.navigationController?.pushViewController(obj!, animated: true)
    }
}
