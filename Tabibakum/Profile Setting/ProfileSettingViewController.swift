//
//  ProfileSettingViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 28/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class ProfileSettingViewController: BaseClassViewController {
    
    @IBOutlet weak var name_Lbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var profile_ImgView: UIImageView!
    @IBOutlet weak var info_view: UIView!
    @IBOutlet weak var update_Btn: UIButton!
    @IBOutlet weak var emailId_Lbl: UILabel!
    @IBOutlet weak var phoneNumber_Lbl: UILabel!
    @IBOutlet weak var dateofBirth_Lbl: UILabel!
    @IBOutlet weak var gender_Lbl: UILabel!
    @IBOutlet weak var weight_Lbl: UILabel!
    @IBOutlet weak var height_Lbl: UILabel!
    @IBOutlet weak var facebook_Lbl: UILabel!
    @IBOutlet weak var address_Lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileApi()
        profile_ImgView.layer.cornerRadius = profile_ImgView.frame.height/2
        profile_ImgView.clipsToBounds = true
        info_view.layer.cornerRadius = 10
        update_Btn.layer.cornerRadius = update_Btn.frame.height/2
        update_Btn.clipsToBounds = true
        info_view.layer.borderColor = UIColor(red: 230/254, green: 230/254, blue: 230/254, alpha: 1.0).cgColor
        info_view.layer.borderWidth = 1
        info_view.layer.cornerRadius = 10
        info_view.clipsToBounds = true
        update_Btn.backgroundColor = UiInterFace.appThemeColor
        navigationController?.navigationBar.backgroundColor = UiInterFace.appThemeColor
        self.name_Lbl.text = ""
        self.phoneNumber_Lbl.text = ""
        self.emailId_Lbl.text = ""
        self.dateofBirth_Lbl.text = ""
        self.gender_Lbl.text = ""
        self.weight_Lbl.text = ""
        self.height_Lbl.text = ""
        self.description_Lbl.text = ""
        self.facebook_Lbl.text = ""
        self.address_Lbl.text = ""
        
    }
    
    func userProfileApi(){
       self.showCustomProgress()
        let useid = UserDefaults.standard.integer(forKey: "userId")
        let api = Configurator.baseURL + ApiEndPoints.userdata + "?user_id=\(useid)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.stopProgress()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for userData in dataDict! {
                    self.name_Lbl.text = userData["name"] as? String
                    let img =  userData["avatar"] as? String
                    let imageStr = Configurator.imageBaseUrl + img!
                    self.profile_ImgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
                    
                    self.phoneNumber_Lbl.text = userData["phone"] as? String
                    self.emailId_Lbl.text = userData["email"] as? String
                    self.dateofBirth_Lbl.text = userData["date_of_birth"] as? String
                    self.gender_Lbl.text = userData["gender"] as? String
                    self.weight_Lbl.text = userData["weight"] as? String
                    self.height_Lbl.text = userData["height"] as? String
                    self.description_Lbl.text = userData["description"] as? String
                    self.facebook_Lbl.text = userData["facebook"] as? String
                    self.address_Lbl.text = userData["address"] as? String
                }
         }
    }
    
    @IBAction func actionUpdateBtn(_ sender: Any) {
        let profileUpdate = self.storyboard?.instantiateViewController(withIdentifier: "PatientProfileUpdateViewController") as! PatientProfileUpdateViewController
        self.navigationController?.pushViewController(profileUpdate, animated: true)
    }
}
