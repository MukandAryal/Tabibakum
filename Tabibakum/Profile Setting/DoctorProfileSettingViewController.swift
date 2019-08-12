//
//  DoctorProfileSettingViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class DoctorProfileSettingViewController: BaseClassViewController {
    @IBOutlet weak var info_view: UIView!
    @IBOutlet weak var userImg_VIew: UIImageView!
    @IBOutlet weak var update_Btn: UIButton!
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var specialist_Lbl: UILabel!
    @IBOutlet weak var emailAddress_Lbl: UILabel!
    @IBOutlet weak var experience_Lbl: UILabel!
    @IBOutlet weak var gender_Lbl: UILabel!
    @IBOutlet weak var dateofBirth_Lbl: UILabel!
    @IBOutlet weak var phoneNumber_Lbl: UILabel!
    @IBOutlet weak var facebooklink_Lbl: UILabel!
    @IBOutlet weak var fees_Lbl: UILabel!
    @IBOutlet weak var name_Lbl: UILabel!
    @IBOutlet weak var address_Lbl: UILabel!
    @IBOutlet weak var education_Lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImg_VIew.layer.cornerRadius = userImg_VIew.frame.height/2
        userImg_VIew.clipsToBounds = true
        info_view.layer.cornerRadius = 10
        update_Btn.layer.cornerRadius = update_Btn.frame.height/2
        update_Btn.clipsToBounds = true
        info_view.layer.borderColor = UIColor(red: 230/254, green: 230/254, blue: 230/254, alpha: 1.0).cgColor
        info_view.layer.borderWidth = 1
        info_view.layer.cornerRadius = 10
        info_view.clipsToBounds = true
        userProfileApi()
        self.name_Lbl.text = ""
        self.phoneNumber_Lbl.text = ""
        self.education_Lbl.text = ""
        self.dateofBirth_Lbl.text = ""
        self.gender_Lbl.text = ""
        self.specialist_Lbl.text = ""
        self.fees_Lbl.text = ""
        self.description_Lbl.text = ""
        self.facebooklink_Lbl.text = ""
        self.address_Lbl.text = ""
        self.experience_Lbl.text = ""
        self.emailAddress_Lbl.text = ""
    }
    
    func userProfileApi(){
       self.showCustomProgress()
        let useid = UserDefaults.standard.integer(forKey: "userId")
        let api = Configurator.baseURL + ApiEndPoints.userdata + "?user_id=\(useid)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
             //   print(response)
               
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for userData in dataDict! {
                   
                    self.name_Lbl.text = userData["name"] as? String
                    let img =  userData["avatar"] as? String
                    let imageStr = Configurator.imageBaseUrl + img!
                    self.userImg_VIew.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
                     self.specialist_Lbl.text = userData["specialist"] as? String
                     self.education_Lbl.text = userData["education"] as? String
                     self.experience_Lbl.text = userData["experience"] as? String
                    self.emailAddress_Lbl.text = userData["email"] as? String
                    self.dateofBirth_Lbl.text = userData["date_of_birth"] as? String
                    self.gender_Lbl.text = userData["gender"] as? String
                    self.description_Lbl.text = userData["description"] as? String
                     self.fees_Lbl.text = userData["fees"] as? String
                }
                 self.stopProgress()
        }
    }
    
    
    
    @IBAction func actionUpdateBtn(_ sender: Any) {
        let Obj = self.storyboard?.instantiateViewController(withIdentifier: "ProfileUpdateViewController") as! ProfileUpdateViewController
        self.navigationController?.pushViewController(Obj, animated: true)
    }
    
}
