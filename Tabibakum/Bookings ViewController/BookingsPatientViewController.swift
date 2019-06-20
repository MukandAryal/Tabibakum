//
//  BookingsPatientViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 28/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SDWebImage

struct allBookingHistory {
    struct bookingHistoryDetails {
        var patient_id : Int?
        var doctor_id  : Int?
        var from : String?
        var froms : String?
        var to : String?
        var id : Int?
        var name : String?
        var type : Int?
        var avatar : String?
        var specialist :  String?
        var created_at : String?
        var updated_at : String?
    }
    var historyInfo : [allBookingHistory]
}

class BookingsPatientViewController: UIViewController {
    @IBOutlet weak var bookingsTblView: UITableView!
    @IBOutlet var booking_View: UIView!
    @IBOutlet weak var delete_Btn: UIButton!
    
    var doctorInfoArr = [allBookingHistory.bookingHistoryDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // bookingsTblView.isHidden = true
        delete_Btn.isHidden = true
        setupSideMenu()
        setDefaults()
        
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
                let dataDict = resultDict!["data"] as! [[String:AnyObject]]
                if dataDict.count != 0 {
                    self.delete_Btn.isHidden = false
                }
                for specialistObj in dataDict {
                    print(specialistObj)
                    var doctorDetails = [String:AnyObject]()
                    if  UserDefaults.standard.integer(forKey: "loginType") == 0{
                        doctorDetails = (specialistObj["doctor_detail"] as? [String:AnyObject])!
                    }else{
                        doctorDetails = (specialistObj["patient_detail"] as? [String:AnyObject])!
                    }
                    let doctInfo = allBookingHistory.bookingHistoryDetails(patient_id: specialistObj["patient_id"] as? Int, doctor_id: specialistObj["doctor_id"] as? Int, from: specialistObj["from"] as? String, froms: specialistObj["froms"] as? String, to: specialistObj["to"] as? String, id: doctorDetails["id"] as? Int, name: doctorDetails["name"] as? String, type: doctorDetails["type"] as? Int, avatar: doctorDetails["avatar"] as? String, specialist: doctorDetails["specialist"] as? String, created_at: doctorDetails["created_at"] as? String, updated_at: doctorDetails["updated_at"] as? String)
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
                    if currenTymSptamp>dateTymStamp{
                        self.doctorInfoArr.append(doctInfo)
                    }
                    print(self.doctorInfoArr)
                    self.bookingsTblView.reloadData()
                }
          }
    }
    

    @IBAction func actionNewComplaintBtn(_ sender: Any) {
        let doctorsObj = self.storyboard?.instantiateViewController(withIdentifier: "AvailableDoctorsViewController") as! AvailableDoctorsViewController
        self.navigationController?.pushViewController(doctorsObj, animated: true)
        
    }
}

extension BookingsPatientViewController : UITableViewDataSource{
    
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
        dateFormatterGet.dateFormat = "dd-mm-yyyy-"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
        
        if let date = dateFormatterGet.date(from:  doctorInfoArr[indexPath.row].from!) {
            print(dateFormatterPrint.string(from: date))
            cell.date_Lbl.text = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        let fromTime = doctorInfoArr[indexPath.row].from
        let fromTym = fromTime!.suffix(8)
        print(fromTym)
        let toTime = doctorInfoArr[indexPath.row].to
        let toTym = toTime!.suffix(8)
        cell.time_lbl.text = fromTym.description + " " + toTym.description
        let imageStr = Configurator.imageBaseUrl + doctorInfoArr[indexPath.row].avatar!
        cell.userImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        return cell
    }
}

extension BookingsPatientViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
