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


struct allDoctorInfo {
    struct docotrDetails {
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
    var doctInfo : [allDoctorInfo]
}

class HomeViewController: UIViewController {
    @IBOutlet weak var bookingHistoryTblView: UITableView!
    @IBOutlet weak var singOut_View: UIView!
    @IBOutlet weak var logout_Btn: UIButton!
    @IBOutlet weak var stayLoggedIn_Btn: UIButton!
    var doctorInfoArr = [allDoctorInfo.docotrDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setDefaults()
        
        bookingHistoryTblView.register(UINib(nibName: "BookingPatientTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingPatientTableViewCell")
        bookingHistoryTblView.tableFooterView = UIView()
        bookingHistoryTblView.separatorStyle = .none
        // bookingHistoryTblView.separatorInset = .zero
        bookingHistoryTblView.separatorInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        
        singOut_View.layer.cornerRadius = 10
        singOut_View.clipsToBounds = true
        
        logout_Btn.layer.cornerRadius = logout_Btn.frame.height/2
        logout_Btn.clipsToBounds = true
        
        stayLoggedIn_Btn.layer.cornerRadius = stayLoggedIn_Btn.frame.height/2
        stayLoggedIn_Btn.clipsToBounds = true
        singOut_View.isHidden = true
        bookingPatientListApi()
        bookingHistoryTblView.reloadData()
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
    
    func bookingPatientListApi(){
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
                    let doctInfo = allDoctorInfo.docotrDetails(patient_id: (specialistObj["patient_id"] as? Int)!, doctor_id: (specialistObj["doctor_id"] as? Int)!, from: (specialistObj["from"] as? String)!, froms: (specialistObj["froms"] as? String)!, to: (specialistObj["to"] as? String)!, id: (doctorDetails["id"] as? Int)!, name: (doctorDetails["name"] as? String)!, type: (doctorDetails["type"] as? Int)!, avatar: (doctorDetails["avatar"] as? String)!, specialist: (doctorDetails["specialist"] as? String)!, created_at: (doctorDetails["created_at"] as? String)!, updated_at: (doctorDetails["updated_at"] as? String)!)
                    self.doctorInfoArr.append(doctInfo)
                    print(self.doctorInfoArr)
                    LoadingIndicatorView.hide()
                    self.bookingHistoryTblView.reloadData()
                }
        }
    }
    
    func getDateFromString(dateFormat:String , dateStr: String) ->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        guard let date = dateFormatter.date(from: dateStr) else {
            fatalError()
        }
        print(date)
        return date
    }
}

extension HomeViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingPatientTableViewCell") as! BookingPatientTableViewCell
        print(doctorInfoArr[indexPath.row].avatar)
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

extension HomeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileViewController") as! DoctorProfileViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
}

