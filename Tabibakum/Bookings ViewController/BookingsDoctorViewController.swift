//
//  BookingsDoctorViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 02/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire

class BookingsDoctorViewController: BaseClassViewController {
    @IBOutlet weak var bookingsTblView: UITableView!
    @IBOutlet var booking_View: UIView!
    @IBOutlet weak var delete_Btn: UIButton!
    @IBOutlet weak var no_historyImgage: UIImageView!
    @IBOutlet weak var no_appiontmentLbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!
    
    @IBOutlet weak var empty_view: UIView!
    var doctorInfoArr = [allBookingHistory.bookingHistoryDetails]()
    var toStr = ""
    var toStr_ = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setDefaults()
        self.no_historyImgage.isHidden = true
        self.no_appiontmentLbl.isHidden = true
        self.description_Lbl.isHidden = true
        delete_Btn.isHidden = true
        bookingsTblView.register(UINib(nibName: "BookingHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingHistoryTableViewCell")
        bookingHistoryListApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setDefaults() {
        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .menuDissolveIn]
        
    }
    
    func bookingHistoryListApi(){
        self.showCustomProgress()
        let useid = UserDefaults.standard.integer(forKey: "userId")
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.currentbooking + "?doctor_id=\(useid)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
            //    print(response)
                self.stopProgress()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as! [[String:AnyObject]]
                for specialistObj in dataDict {
                    print(specialistObj)
                    var doctorDetails = [String:AnyObject]()
                    if  UserDefaults.standard.integer(forKey: "loginType") == 0{
                        doctorDetails = (specialistObj["doctor_detail"] as? [String:AnyObject])!
                    }else{
                        doctorDetails = (specialistObj["patient_detail"] as? [String:AnyObject])!
                    }
                    if doctorDetails.count == 0 {
                        self.bookingsTblView.isHidden = true
                        self.no_historyImgage.isHidden = false
                        self.no_appiontmentLbl.isHidden = false
                        self.description_Lbl.isHidden = false
                        self.delete_Btn.isHidden = false
                       self.empty_view.backgroundColor = UIColor(red: 246/254, green: 246/254, blue: 246/254, alpha: 1.0)
                    }
                    let doctInfo = allBookingHistory.bookingHistoryDetails(appointment_id: specialistObj["id"] as? Int,patient_id: specialistObj["patient_id"] as? Int, doctor_id: specialistObj["doctor_id"] as? Int, from: specialistObj["from"] as? String, froms: specialistObj["froms"] as? String, to: specialistObj["to"] as? String, id: doctorDetails["id"] as? Int, name: doctorDetails["name"] as? String, type: doctorDetails["type"] as? Int, avatar: doctorDetails["avatar"] as? String, specialist: doctorDetails["specialist"] as? String, created_at: doctorDetails["created_at"] as? String, updated_at: doctorDetails["updated_at"] as? String)
                    print(doctInfo)
                    let dateFormatterGet = DateFormatter()
                    let currentDateTime = Date()
                    let currenTymSptamp = currentDateTime.timeIntervalSince1970
                    print(currenTymSptamp)
                    var dateTymStamp = TimeInterval()
                    dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    if let date = dateFormatterGet.date(from: (specialistObj["to"] as? String)!){
                        print(dateFormatterPrint.string(from: date))
                        dateTymStamp = date.timeIntervalSince1970
                        print(dateTymStamp)
                    }
                    
                    if currenTymSptamp>dateTymStamp{
                        self.doctorInfoArr.append(doctInfo)
                        self.delete_Btn.isHidden = false
                    }
                }
                
                if self.doctorInfoArr.count == 0 {
                    self.bookingsTblView.isHidden = true
                    self.no_historyImgage.isHidden = false
                    self.no_appiontmentLbl.isHidden = false
                    self.description_Lbl.isHidden = false
                    self.delete_Btn.isHidden = false
                    self.empty_view.backgroundColor = UIColor(red: 246/254, green: 246/254, blue: 246/254, alpha: 1.0)
                   
                }
                self.stopProgress()
                self.bookingsTblView.reloadData()
                self.delete_Btn.isHidden = false
        }
    }
    
    func BookingHistoryDeleteApi(){
        let useid = UserDefaults.standard.integer(forKey: "userId")
        self.showCustomProgress()
        let param: [String: Any] = [
            "doctor_id" : useid,
            "from" : toStr_
        ]
        
        print(param)
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.delete_booking
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
             //   print(response)
               self.stopProgress()
                let resultDict = response.value as? [String: AnyObject]
                if let sucessStr = resultDict!["success"] as? Bool{
                    print(sucessStr)
                    if sucessStr{
                        print("sucessss")
                        self.doctorInfoArr.removeAll()
                        self.dismiss(animated: true, completion: nil)
                        self.bookingsTblView.isHidden = true
                        self.no_historyImgage.isHidden = false
                        self.no_appiontmentLbl.isHidden = false
                        self.description_Lbl.isHidden = false
                        self.delete_Btn.isHidden = true
                    }else {
                        let alert = UIAlertController(title: "Alert", message: "sumthing woring!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
    }
    
    
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let deleteVc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteConfirmViewController") as? DeleteConfirmViewController
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: deleteVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        deleteVc?.titleLabel.text = "Are you sure you want to clear History."
        deleteVc!.yesBtn.addTargetClosure { _ in
            // popup.dismiss()
            self.BookingHistoryDeleteApi()
            
        }
        deleteVc!.noBtn.addTargetClosure { _ in
            popup.dismiss()
            
            self.delete_Btn.isEnabled = true
        }
        
        present(popup, animated: animated, completion: nil)
    }
    
    
    @IBAction func actionDeleteBtn(_ sender: Any) {
        showCustomDialog()
    }
}

extension BookingsDoctorViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingHistoryTableViewCell") as! BookingHistoryTableViewCell
        
        cell.user_NameLbl.text = doctorInfoArr[indexPath.row].name!.capitalized
        cell.spcialist_Lbl.text = doctorInfoArr[indexPath.row].specialist
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd MMMM yyyy hh:mm aa"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        if let date = dateFormatterGet.date(from:  doctorInfoArr[indexPath.row].from!) {
            print(dateFormatterPrint.string(from: date))
            cell.date_Lbl.text = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        var fromTym = ""
        if let fromTime = doctorInfoArr[indexPath.row].from{
            if toStr_ == ""{
                toStr_ = "\(toStr_) \(fromTime)"
                print(toStr_)
            }
            else{
                toStr_ = "\(toStr_), \(fromTime)"
                print(toStr_)
            }
            print("toStr>>>>>>",toStr_)
            fromTym = String(fromTime.suffix(8))
        }
        let toTime = doctorInfoArr[indexPath.row].to
        let toTym = toTime!.suffix(8)
        cell.time_lbl.text = fromTym.description + " " + toTym.description
        let imageStr = Configurator.imageBaseUrl + doctorInfoArr[indexPath.row].avatar!
        cell.userImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        return cell
    }
}

extension BookingsDoctorViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "PatientProfileViewController") as! PatientProfileViewController
        print(doctorInfoArr[indexPath.row])
        obj.doctorId = doctorInfoArr[indexPath.row].patient_id!
        obj.appointmentId = doctorInfoArr[indexPath.row].appointment_id!
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

