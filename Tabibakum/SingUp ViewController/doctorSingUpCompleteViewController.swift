//
//  doctorSingUpCompleteViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 13/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class doctorSingUpCompleteViewController: BaseClassViewController {
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var next_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        next_Btn.layer.cornerRadius = next_Btn.frame.height/2
        next_Btn.clipsToBounds = true
    }
    
    func totalPostApi(){
        self.showCustomProgress()
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        let param: [String: Any] = [
            "token" : loginToken!,
            "totalfilled" : "1"
        ]
        let api = Configurator.baseURL + ApiEndPoints.posttotal
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                self.stopProgress()
                print(response)
                var resultDict = response.value as? [String:Any]
                if let sucessStr = resultDict!["success"] as? Bool{
                    print(sucessStr)
                    if sucessStr{
                        print("sucessss")
                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        self.navigationController?.pushViewController(obj, animated: true)
                    }
                }
        }
    }
    
    @IBAction func actionDoneBtn(_ sender: Any) {
       totalPostApi()
    }
}
