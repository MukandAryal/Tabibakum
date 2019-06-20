//
//  AvailableDoctorsViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

struct allDoctorList {
    struct doctorDetails {
        var id : Int?
        var name: String?
        var type: Int?
        var avatar: String?
        var specialist: String?
        var education: String?
        var experience: String?
        var fees: String?
        var country_code: String?
        var phone: String?
        var email: String?
        var date_of_birth: String?
        var gender: String?
        var weight: String?
        var height: String?
        var bloodtype: String?
        var facebook: String?
        var totalfilled: Int?
        var address: String?
        var description: String?
        var age: String?
        var verified: Int?
        var email_verified_at:  String?
        var password:  String?
        var remember_token:  String?
        var update_on: String?
        var created_at:  String?
        var updated_at:  String?
    }
    var docotrInfo : [allDoctorList]
}

class AvailableDoctorsViewController: UIViewController {
    
    @IBOutlet weak var availbleDoctorsTblView: UITableView!
    @IBOutlet weak var search_View: UIView!
    @IBOutlet weak var search_txtFld: UITextField!
    
    var doctorListArr = [allDoctorList.doctorDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        availbleDoctorsTblView.register(UINib(nibName: "AvailableDoctorsTableViewCell", bundle: nil), forCellReuseIdentifier: "AvailableDoctorsTableViewCell")
        availbleDoctorsTblView.tableFooterView = UIView()
        search_View.layer.cornerRadius = search_View.frame.height/2
        search_View.clipsToBounds = true
        search_View.layer.borderWidth = 0.5
        search_View.layer.borderColor = UIColor.lightGray.cgColor
        doctorListApi()
    }
    
    func doctorListApi(){
        LoadingIndicatorView.show()
        var api = String()
      //  if indexingValue.questionNaireType == "complaintQuestionNaire"{
            api = Configurator.baseURL + ApiEndPoints.doctorlist
       // }else{
           // api = Configurator.baseURL + ApiEndPoints.patientquestion
       // }
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                LoadingIndicatorView.hide()
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let doctorInfo = allDoctorList.doctorDetails(
                        id: specialistObj["id"] as? Int,
                        name: specialistObj["name"] as? String,
                        type: specialistObj["type"] as? Int,
                        avatar: specialistObj["avatar"] as? String,
                        specialist: specialistObj["specialist"] as? String,
                        education: specialistObj["education"] as? String,
                        experience: specialistObj["experience"] as? String,
                        fees: specialistObj["fees"] as? String,
                        country_code: specialistObj["country_code"] as? String,
                        phone: specialistObj["phone"] as? String,
                        email: specialistObj["email"] as? String,
                        date_of_birth: specialistObj["date_of_birth"] as? String,
                        gender: specialistObj["gender"] as? String,
                        weight: specialistObj["weight"] as? String,
                        height: specialistObj["height"] as? String,
                        bloodtype: specialistObj["bloodtype"] as? String,
                        facebook: specialistObj["facebook"] as? String,
                        totalfilled: specialistObj["totalfilled"] as? Int,
                        address: specialistObj["address"] as? String,
                        description: specialistObj["description"] as? String,
                        age: specialistObj["age"] as? String,
                        verified: specialistObj["verified"] as? Int,
                        email_verified_at: specialistObj["email_verified_at"] as? String,
                        password: specialistObj["password"] as? String,
                        remember_token: specialistObj["remember_token"] as? String,
                        update_on: specialistObj["update_on"] as? String,
                        created_at: specialistObj["created_at"] as? String,
                        updated_at: specialistObj["updated_at"] as? String)
                        self.doctorListArr.append(doctorInfo)
                       self.availbleDoctorsTblView.reloadData()
                }
          }
    }
    
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AvailableDoctorsViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableDoctorsTableViewCell") as! AvailableDoctorsTableViewCell
        cell.user_NameLbl.text = doctorListArr[indexPath.row].name
        let imageStr = Configurator.imageBaseUrl + doctorListArr[indexPath.row].avatar!
        cell.userImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        cell.spcialist_Lbl.text = doctorListArr[indexPath.row].specialist
        cell.date_Lbl.text = doctorListArr[indexPath.row].date_of_birth
        return cell
        
    }
}

extension AvailableDoctorsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
        obj.doctorInfoDetailsArr = doctorListArr[indexPath.row]
        self.navigationController?.pushViewController(obj, animated: true)
    }
}
