//
//  HomeViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 27/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SDWebImage

struct allPatientInfo {
    struct patientDetails {
        var appointment_id : Int?
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
    var patientInfo : [allPatientInfo]
}

class HomeViewController: BaseClassViewController {
    @IBOutlet weak var bookingHistoryTblView: UITableView!
    @IBOutlet weak var description_lbl: UILabel!
    @IBOutlet weak var clieckHere_Btn: UIButton!
    @IBOutlet weak var howcanHelp_lbl: UILabel!
    var patientInfoArr = [allPatientInfo.patientDetails]()
    var userId = Int()
    var questionListArr = [String:AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookingPatientListApi()
        bookingHistoryTblView.register(UINib(nibName: "BookingPatientTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingPatientTableViewCell")
        bookingHistoryTblView.tableFooterView = UIView()
        bookingHistoryTblView.separatorStyle = .none
        // bookingHistoryTblView.separatorInset = .zero
        bookingHistoryTblView.separatorInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        clieckHere_Btn.layer.cornerRadius = 5
        clieckHere_Btn.clipsToBounds = true
        clieckHere_Btn.isHidden = true
        description_lbl.isHidden = true
        howcanHelp_lbl.isHidden = true
        UserDetails()
        indexingValue.questionType.removeAll()
        indexingValue.newBookingQuestionListArr.removeAll()
        indexingValue.indexValue = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if indexingValue.logOutViewString == "logoutOutViewShow"{
            self.logoutView()
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // handle notification
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func bookingPatientListApi(){
        self.showCustomProgress()
        
        let useid = UserDefaults.standard.integer(forKey: "userId")
        let api = Configurator.baseURL + ApiEndPoints.currentbooking + "?doctor=\(useid)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                if dataDict?.count == 0{
                    self.bookingHistoryTblView.isHidden = true
                    self.description_lbl.isHidden = false
                    self.howcanHelp_lbl.isHidden = false
                    self.clieckHere_Btn.isHidden = false
                }
                var i = 0
                for specialistObj in dataDict! {
                    i = i+1
                    let doctorDetails = specialistObj["doctor_detail"]! as? NSDictionary
                    
                    let patientInfo = allPatientInfo.patientDetails(appointment_id: specialistObj["id"] as? Int,patient_id: specialistObj["patient_id"] as? Int, doctor_id: specialistObj["doctor_id"] as? Int, from: specialistObj["from"] as? String, froms: (specialistObj["froms"] as? String)!, to: (specialistObj["to"] as? String)!, id: doctorDetails?["id"] as? Int, name: doctorDetails?["name"] as? String, type: doctorDetails?["type"] as? Int, avatar: doctorDetails?["avatar"] as? String, specialist: doctorDetails?["specialist"] as? String, created_at: doctorDetails?["created_at"] as? String, updated_at: doctorDetails?["updated_at"] as? String)
                    let dateFormatterGet = DateFormatter()
                    let currentDateTime = Date()
                    let currenTymSptamp = currentDateTime.timeIntervalSince1970
                    var dateTymStamp = TimeInterval()
                    dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    if let date = dateFormatterGet.date(from: (specialistObj["to"] as? String)!){
                        print(dateFormatterPrint.string(from: date))
                        dateTymStamp = date.timeIntervalSince1970
                        print(dateTymStamp)
                    }
                    if currenTymSptamp<dateTymStamp{
                        self.patientInfoArr.append(patientInfo)
    
                    }
                    if i == dataDict?.count{
                        self.clieckHere_Btn.setTitle("New Booking", for: .normal)
                        self.description_lbl.isHidden = true
                        self.howcanHelp_lbl.isHidden = true
                        self.clieckHere_Btn.isHidden = false
                        self.bookingHistoryTblView.isHidden = false
                        self.bookingHistoryTblView.reloadData()
                        if self.patientInfoArr.count == 0{
                            self.bookingHistoryTblView.isHidden = true
                            self.description_lbl.isHidden = false
                            self.howcanHelp_lbl.isHidden = false
                            self.clieckHere_Btn.isHidden = false
                        }
                    }
                }
                self.stopProgress()
        }
    }
    
    func UserDetails(){
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        let api = Configurator.baseURL + ApiEndPoints.user_details + "?token=\(loginToken ?? "")"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                let resultDict = response.value as? NSDictionary
                let userDetails = resultDict!["user"] as? NSDictionary
                let loginType = userDetails?.object(forKey: "type") as! Int
                let namestr = userDetails?.object(forKey: "name") as? String
                let userId = userDetails?.object(forKey: "id") as? Int
                let img =  userDetails?.object(forKey: "avatar") as? String
                let imageStr = Configurator.imageBaseUrl + img!
                UserDefaults.standard.set(imageStr, forKey: "loginUserProfileImage")
                UserDefaults.standard.set(namestr, forKey: "loginUserName")
                UserDefaults.standard.set(loginType, forKey: "loginType")
                UserDefaults.standard.set(userId, forKey: "userId")
        }
    }
    
    func complaintQuestionNaireApi(){
        self.showCustomProgress()
        let api = Configurator.baseURL + ApiEndPoints.complaintquestions
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                self.stopProgress()
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                if let sucessStr = resultDict!["success"] as? Bool{
                    print(sucessStr)
                    if sucessStr{
                        print("sucessss")
                        indexingValue.questionNaireType = "complaintQuestionNaire"
                        for specialistObj in dataDict! {
                            print(specialistObj)
                            let type = specialistObj["type"] as? String
                            indexingValue.questionType.append(type!)
                            let id = specialistObj["id"] as? Int
                            self.questionListArr["value"] = type as AnyObject
                            self.questionListArr["id"] = id as AnyObject
                            indexingValue.newBookingQuestionListArr.append(self.questionListArr)
                            print("questionList>>>>>>",indexingValue.newBookingQuestionListArr)
                            indexingValue.indexCount = 0
                        }
                        if indexingValue.questionType.count == indexingValue.indexValue {
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "AvailableDoctorsViewController")as! AvailableDoctorsViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                            print("last index")
                        }
                        else if indexingValue.questionType[indexingValue.indexValue] == "text"{
                            print("text")
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireTextViewController")as! QuestionNaireTextViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                        }else if indexingValue.questionType[indexingValue.indexValue] == "yesno"{
                            print("yes")
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireTextViewController")as! QuestionNaireTextViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                        }else if indexingValue.questionType[indexingValue.indexValue] == "list"{
                            print("list")
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "ListQuestionNaireViewController")as! ListQuestionNaireViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                        }else if indexingValue.questionType[indexingValue.indexValue] == "image"{
                            print("image")
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireImageViewController")as! QuestionNaireImageViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                        }else if indexingValue.questionType[indexingValue.indexValue] == "tab1"{
                            print("tab1")
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireSingalTabViewController")as! QuestionNaireSingalTabViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                        }else if indexingValue.questionType[indexingValue.indexValue] == "tab2"{
                            print("tab2")
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireMultipleTabViewController")as! QuestionNaireMultipleTabViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                        }else if indexingValue.questionType[indexingValue.indexValue] == "tai"{
                            print("tai")
                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QueestionNaireImgeAndTextViewController")as! QueestionNaireImgeAndTextViewController
                            self.navigationController?.pushViewController(Obj, animated:true)
                        }
                        indexingValue.indexValue = indexingValue.indexValue + 1
                    }else{
                        let alert = UIAlertController(title: "Alert", message: "sumthing went wrong please try again!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
    }
    
    @IBAction func actionClickHereBtn(_ sender: Any) {
        complaintQuestionNaireApi()
    }
}


extension HomeViewController : UITableViewDataSource{
    
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
            print(dateFormatterPrint.string(from: date))
            cell.date_Lbl.text = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        let fromTime = patientInfoArr[indexPath.row].from
        let fromTym = fromTime!.suffix(8)
        print(fromTym)
        let toTime = patientInfoArr[indexPath.row].to
        let toTym = toTime!.suffix(8)
        cell.time_lbl.text = fromTym.description + " " + toTym.description
        let imageStr = Configurator.imageBaseUrl + patientInfoArr[indexPath.row].avatar!
        cell.userImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        return cell
    }
}
extension HomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
        obj.doctorId = patientInfoArr[indexPath.row].id
        
        let now = Date()
        var soon = Date()
        var later = Date()
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
        soon = dateFormatterGet.date(from: patientInfoArr[indexPath.row].from!)!
        later = dateFormatterGet.date(from: patientInfoArr[indexPath.row].to!)!
        let range = soon...later
        
        if range.contains(now) {
            obj.type_str = "whtsApp"
        } else {
            obj.type_str = "appointment"
        }
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
}

