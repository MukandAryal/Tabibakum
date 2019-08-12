//
//  DoctorHomeViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 02/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SDWebImage

struct allDoctorInfo {
    struct DoctorDetails {
        var patient_id : Int?
        var doctor_id  : Int?
        var from : String?
        var froms : String?
        var to : String?
        var id : Int?
        var name : String?
        var type : Int?
        var avatar : String?
        var specialist : String?
        var created_at : String?
        var updated_at : String?
    }
    var doctorInfo : [allDoctorInfo]
}

class DoctorHomeViewController: BaseClassViewController {
    @IBOutlet weak var doctorBookingHistoryTblView: UITableView!
    
    @IBOutlet weak var noApponitment_ImgView: UIImageView!
    
    @IBOutlet weak var description_lbl: UILabel!
    
    @IBOutlet weak var howcanHelp_lbl: UILabel!
    var patientInfoArr = [allPatientInfo.patientDetails]()
    var userId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookingPatientListApi()
        doctorBookingHistoryTblView.register(UINib(nibName: "BookingPatientTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingPatientTableViewCell")
        doctorBookingHistoryTblView.tableFooterView = UIView()
        doctorBookingHistoryTblView.separatorStyle = .none
        doctorBookingHistoryTblView.separatorInset = .zero
        doctorBookingHistoryTblView.separatorInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        noApponitment_ImgView.isHidden = true
        description_lbl.isHidden = true
        howcanHelp_lbl.isHidden = true
        getUserDetails()
        indexingValue.questionType.removeAll()
        indexingValue.newBookingQuestionListArr.removeAll()
        indexingValue.indexValue = 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func bookingPatientListApi(){
        self.showCustomProgress()
        let useid = UserDefaults.standard.integer(forKey: "userId")
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.currentbooking + "?doctor_id=\(useid)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                var i = 0
                if dataDict?.count == 0{
                    self.doctorBookingHistoryTblView.isHidden = true
                    self.noApponitment_ImgView.isHidden = false
                    self.description_lbl.isHidden = false
                    self.howcanHelp_lbl.isHidden = false
                }
                for specialistObj in dataDict! {
                    i = i+1
                    let doctorDetails = specialistObj["patient_detail"]! as? NSDictionary
                    let patientInfo = allPatientInfo.patientDetails(appointment_id: specialistObj["id"] as? Int,patient_id: specialistObj["patient_id"] as? Int, doctor_id: specialistObj["doctor_id"] as? Int, from: specialistObj["from"] as? String, froms: (specialistObj["froms"] as? String)!, to: (specialistObj["to"] as? String)!, id: doctorDetails?["id"] as? Int, name: doctorDetails?["name"] as? String, type: doctorDetails?["type"] as? Int, avatar: doctorDetails?["avatar"] as? String, specialist: doctorDetails?["specialist"] as? String, created_at: doctorDetails?["created_at"] as? String, updated_at: doctorDetails?["updated_at"] as? String)
                    print(patientInfo)
                    let dateFormatterGet = DateFormatter()
                    let currentDateTime = Date()
                    let currenTymSptamp = currentDateTime.timeIntervalSince1970
                    var dateTymStamp = TimeInterval()
                    dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    if let date = dateFormatterGet.date(from: (specialistObj["to"] as? String)!){
                        dateTymStamp = date.timeIntervalSince1970
                    }
                    if currenTymSptamp<dateTymStamp{
                        self.patientInfoArr.append(patientInfo)
                    }
                    if i == dataDict?.count{
                        self.doctorBookingHistoryTblView.isHidden = false
                        self.noApponitment_ImgView.isHidden = true
                        self.description_lbl.isHidden = true
                        self.howcanHelp_lbl.isHidden = true
                        self.doctorBookingHistoryTblView.reloadData()
                        if self.patientInfoArr.count == 0{
                            self.doctorBookingHistoryTblView.isHidden = true
                            self.noApponitment_ImgView.isHidden = false
                            self.description_lbl.isHidden = false
                            self.howcanHelp_lbl.isHidden = false
                        }
                    }
                }
                self.stopProgress()
        }
    }
    
    func getUserDetails(){
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        let api = Configurator.baseURL + ApiEndPoints.user_details + "?token=\(loginToken ?? "")"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                self.stopProgress()
                let resultDict = response.value as? NSDictionary
                let userDetails = resultDict!["user"] as? NSDictionary
                let namestr = userDetails?.object(forKey: "name") as? String
                self.userId = userDetails?.object(forKey: "id") as! Int
                let type = userDetails?.object(forKey: "type") as! Int
                let img =  userDetails?.object(forKey: "avatar") as? String
                let userId = userDetails?.object(forKey: "id") as? Int
                let imageStr = Configurator.imageBaseUrl + img!
                UserDefaults.standard.set(type, forKey: "loginType")
                UserDefaults.standard.set(userId, forKey: "userId")
                UserDefaults.standard.set(imageStr, forKey: "loginUserProfileImage")
                UserDefaults.standard.set(namestr, forKey: "loginUserName")
        }
    }
}

extension DoctorHomeViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingPatientTableViewCell") as! BookingPatientTableViewCell
        cell.user_NameLbl.text = patientInfoArr[indexPath.row].name!.capitalized
        cell.spcialist_Lbl.text = patientInfoArr[indexPath.row].specialist
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        if let date = dateFormatterGet.date(from:  patientInfoArr[indexPath.row].from!) {
            cell.date_Lbl.text = dateFormatterPrint.string(from: date)
            cell.date_Lbl.textColor = UiInterFace.appThemeColor
        } else {
        }
        let fromTime = patientInfoArr[indexPath.row].from
        let fromTym = fromTime!.suffix(8)
        let toTime = patientInfoArr[indexPath.row].to
        let toTym = toTime!.suffix(8)
        cell.time_lbl.text = fromTym.description + " " + toTym.description
        let imageStr = Configurator.imageBaseUrl + patientInfoArr[indexPath.row].avatar!
        cell.userImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        return cell
    }
}

extension DoctorHomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "PatientProfileViewController") as! PatientProfileViewController
        obj.doctorId = patientInfoArr[indexPath.row].patient_id!
        obj.appointmentId = patientInfoArr[indexPath.row].appointment_id!
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

