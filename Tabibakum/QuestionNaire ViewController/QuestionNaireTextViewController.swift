//
//  QuestionNaireTextViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 11/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class QuestionNaireTextViewController: UIViewController {
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var questionNaire_Lbl: UILabel!
    @IBOutlet weak var enterQuestionText_fld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enterQuestionText_fld.layer.cornerRadius = 5
        enterQuestionText_fld.clipsToBounds = true
        enterQuestionText_fld.layer.borderWidth = 0.5
        enterQuestionText_fld.layer.borderColor = UIColor.lightGray.cgColor
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        enterQuestionText_fld.setLeftPaddingPoints(5)
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
                    if type == "text"{
                        self.questionNaire_Lbl.text = specialistObj["question"] as? String
                    }
                }
        }
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSkipBtn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireImageViewController") as? QuestionNaireImageViewController
        self.navigationController?.pushViewController(obj!, animated: true)
    }
    
}
