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
        var patient_id : Int
        var doctor_id  : Int
        var from : String
        var froms : String
        var to : String
        var id : Int
        var name : String
        var type : Int
        var avatar : String
        var specialist : String
        var created_at : String
        var updated_at : String
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
      //  delete_Btn.isHidden = true
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
        let param: [String: String] = [
            "patient_id" : "311"
        ]
        LoadingIndicatorView.show()
        //  let api = Configurator.baseURL + ApiEndPoints.currentbooking
        Alamofire.request("http://18.224.27.255:8000/api/currentbooking?patient_id=311", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let doctorDetails = specialistObj["doctor_detail"] as! [String:AnyObject]
                    let doctInfo = allBookingHistory.bookingHistoryDetails(patient_id: (specialistObj["patient_id"] as? Int)!, doctor_id: (specialistObj["doctor_id"] as? Int)!, from: (specialistObj["from"] as? String)!, froms: (specialistObj["froms"] as? String)!, to: (specialistObj["to"] as? String)!, id: (doctorDetails["id"] as? Int)!, name: (doctorDetails["name"] as? String)!, type: (doctorDetails["type"] as? Int)!, avatar: (doctorDetails["avatar"] as? String)!, specialist: (doctorDetails["specialist"] as? String)!, created_at: (doctorDetails["created_at"] as? String)!, updated_at: (doctorDetails["updated_at"] as? String)!)
                    self.doctorInfoArr.append(doctInfo)
                    print(self.doctorInfoArr)
                    LoadingIndicatorView.hide()
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

        

        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let year =  components.year
        let month = components.month
        let day = components.day
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print(year as Any)
        print(month as Any)
        print(day as Any)
        print(hour)
        print(minutes)
        
//        let todate = Date()
//        let tocalendar = doctorInfoArr[indexPath.row].to
//        let tocomponents = tocalendar.dateComponents([.year, .month, .day], from: date)
//        let toyear =  components.year
//        let tomonth = components.month
//        let today = components.day
//        let tohour = calendar.component(.hour, from: date)
//        let tominutes = calendar.component(.minute, from: date)
//        print(toyear as Any)
//        print(tomonth as Any)
//        print(today as Any)
//        print(tohour as Any)
//        print(tominutes)
//        print(minutes)
        
        cell.user_NameLbl.text = doctorInfoArr[indexPath.row].name.capitalized
        cell.spcialist_Lbl.text = doctorInfoArr[indexPath.row].specialist
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM-d-yyyy"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
        
        if let date = dateFormatterGet.date(from:  doctorInfoArr[indexPath.row].from) {
            print(dateFormatterPrint.string(from: date))
            cell.date_Lbl.text = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        
        let fromTime = doctorInfoArr[indexPath.row].from
        let fromTym = fromTime.suffix(8)
        print(fromTym)
        let toTime = doctorInfoArr[indexPath.row].to
        let toTym = toTime.suffix(8)
        cell.time_lbl.text = fromTym.description + " " + toTym.description
        let imageStr = Configurator.imageBaseUrl + doctorInfoArr[indexPath.row].avatar
        cell.userImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        return cell
    }
}

extension BookingsPatientViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
