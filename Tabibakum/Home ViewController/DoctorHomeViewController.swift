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

class DoctorHomeViewController: UIViewController {
    @IBOutlet weak var doctorBookingHistoryTblView: UITableView!
    
    @IBOutlet weak var noApponitment_ImgView: UIImageView!
    
    @IBOutlet weak var description_lbl: UILabel!

    @IBOutlet weak var howcanHelp_lbl: UILabel!
    var patientInfoArr = [allPatientInfo.patientDetails]()
    var userId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setDefaults()
        doctorBookingHistoryTblView.register(UINib(nibName: "BookingPatientTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingPatientTableViewCell")
        doctorBookingHistoryTblView.tableFooterView = UIView()
        doctorBookingHistoryTblView.separatorStyle = .none
        doctorBookingHistoryTblView.separatorInset = .zero
        doctorBookingHistoryTblView.separatorInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        noApponitment_ImgView.isHidden = true
        description_lbl.isHidden = true
        howcanHelp_lbl.isHidden = true
        doctorBookingHistoryTblView.reloadData()
        getUserDetails()
        indexingValue.questionType.removeAll()
        
     //   NotificationCenter.default.addObserver(self, selector: #selector(self.logoutBtn(_:)), name: NSNotification.Name(rawValue: "notificationlogout"), object: nil)
        
       // NotificationCenter.default.addObserver(self, selector: #selector(self.notificationstayLoggedIn(_:)), name: NSNotification.Name(rawValue: "notificationstayLoggedIn"), object: nil)
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "DocotorLeftMenuNavigationController") as? UISideMenuNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setDefaults() {
        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .menuDissolveIn]
    }
    
    func bookingPatientListApi(){
        LoadingIndicatorView.show()
        let useid = UserDefaults.standard.integer(forKey: "userId")
        var api = String()
        if  UserDefaults.standard.integer(forKey: "loginType") == 0{
            api = Configurator.baseURL + ApiEndPoints.currentbooking + "?patient_id=\(useid)"
        }else{
            api = Configurator.baseURL + ApiEndPoints.currentbooking + "?doctor_id=\(useid)"
        }
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                LoadingIndicatorView.hide()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                if dataDict!.count == 0 {
                    self.doctorBookingHistoryTblView.isHidden = true
                    self.noApponitment_ImgView.isHidden = false
                    self.description_lbl.isHidden = false
                    self.howcanHelp_lbl.isHidden = false
                }
                for specialistObj in dataDict! {
                    print(specialistObj)
                    var doctorDetails = [String:AnyObject]()
                    if  UserDefaults.standard.integer(forKey: "loginType") == 0{
                        doctorDetails = (specialistObj["doctor_detail"] as? [String:AnyObject])!
                    }else{
                        doctorDetails = (specialistObj["patient_detail"] as? [String:AnyObject])!
                    }
                    let patientInfo = allPatientInfo.patientDetails(patient_id: specialistObj["patient_id"] as? Int, doctor_id: specialistObj["doctor_id"] as? Int, from: specialistObj["from"] as? String, froms: (specialistObj["froms"] as? String)!, to: (specialistObj["to"] as? String)!, id: doctorDetails["id"] as? Int, name: doctorDetails["name"] as? String, type: doctorDetails["type"] as? Int, avatar: doctorDetails["avatar"] as? String, specialist: doctorDetails["specialist"] as? String, created_at: doctorDetails["created_at"] as? String, updated_at: doctorDetails["updated_at"] as? String)
                    let dateFormatterGet = DateFormatter()
                    let currentDateTime = Date()
                    let currenTymSptamp = currentDateTime.timeIntervalSince1970
                    print(currenTymSptamp)
                    var dateTymStamp = TimeInterval()
                    dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = dateFormatterGet.date(from: (specialistObj["to"] as? String)!)
                    print(dateFormatterPrint.string(from: date!))
                    dateTymStamp = date!.timeIntervalSince1970
                    print(dateTymStamp)
                    if currenTymSptamp<dateTymStamp{
                        self.patientInfoArr.append(patientInfo)
                    }
                    print(self.patientInfoArr)
                    self.doctorBookingHistoryTblView.reloadData()
                }
        }
    }
    
    func getUserDetails(){
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        LoadingIndicatorView.show()
        let api = Configurator.baseURL + ApiEndPoints.user_details + "?token=\(loginToken ?? "")"
        
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                LoadingIndicatorView.hide()
                let resultDict = response.value as? NSDictionary
                let userDetails = resultDict!["user"] as? NSDictionary
                self.userId = userDetails?.object(forKey: "id") as! Int
                let type = userDetails?.object(forKey: "type") as! Int
                print(type)
                UserDefaults.standard.set(type, forKey: "loginType")
                UserDefaults.standard.set(self.userId, forKey: "userId")
                self.bookingPatientListApi()
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
        dateFormatterGet.dateFormat = "dd-mm-yyyy-"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
        
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

extension DoctorHomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
            obj.whtsAppIcon = "whtsAppIcon"
            self.navigationController?.pushViewController(obj, animated: true)
        }else if indexPath.row == 1{
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
            obj.appoinotmentDetails = "appoinotmentDetails"
            self.navigationController?.pushViewController(obj, animated: true)
        }else {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
            self.navigationController?.pushViewController(obj, animated: true)
        }
    }
}

