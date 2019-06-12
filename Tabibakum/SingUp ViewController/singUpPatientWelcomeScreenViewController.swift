//
//  singUpPatientWelcomeScreenViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 12/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class singUpPatientWelcomeScreenViewController: UIViewController {
    @IBOutlet weak var welcome_Lbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var next_Btn: UIButton!
    var questionType = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    self.questionType.append(type!)
                    print(self.questionType)
              }
         }
    }
    @IBAction func actionNextBtn(_ sender: Any) {
    }
}
