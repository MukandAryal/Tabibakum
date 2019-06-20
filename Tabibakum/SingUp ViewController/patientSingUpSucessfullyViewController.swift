//
//  patientSingUpSucessfullyViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 13/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class patientSingUpSucessfullyViewController: UIViewController {
    
    @IBOutlet weak var done_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        done_btn.layer.cornerRadius = done_btn.frame.height/2
        done_btn.clipsToBounds = true
    }
    
     override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func totalPostApi(){
        LoadingIndicatorView.show()
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        let param: [String: Any] = [
            "token" : loginToken!,
            "totalfilled" : "1"
        ]
        let api = Configurator.baseURL + ApiEndPoints.posttotal
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                LoadingIndicatorView.hide()
                print(response)
                var resultDict = response.value as? [String:Any]
                if let sucessStr = resultDict!["success"] as? Bool{
                    print(sucessStr)
                    if sucessStr{
                        print("sucessss")
                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        self.navigationController?.pushViewController(obj, animated: true)
                    }
                }
         }
    }
    
    @IBAction func actionDoneBtn(_ sender: Any) {
        totalPostApi()
    }
}
