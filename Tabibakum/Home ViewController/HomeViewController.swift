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
    var doctInfo : [allDoctorInfo]
}

class HomeViewController: UIViewController {
    @IBOutlet weak var bookingHistoryTblView: UITableView!
    @IBOutlet weak var singOut_View: UIView!
    @IBOutlet weak var logout_Btn: UIButton!
    @IBOutlet weak var stayLoggedIn_Btn: UIButton!
    @IBOutlet weak var description_lbl: UILabel!
    @IBOutlet weak var clieckHere_Btn: UIButton!
    @IBOutlet weak var howcanHelp_lbl: UILabel!
    var doctorInfoArr = [allDoctorInfo.docotrDetails]()
    var userId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setDefaults()
        
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
        
       // singOut_View.layer.cornerRadius = 10
       // singOut_View.clipsToBounds = true
        
       // logout_Btn.layer.cornerRadius = logout_Btn.frame.height/2
     //   logout_Btn.clipsToBounds = true
        
        //stayLoggedIn_Btn.layer.cornerRadius = stayLoggedIn_Btn.frame.height/2
        //stayLoggedIn_Btn.clipsToBounds = true
       // singOut_View.isHidden = true
        bookingHistoryTblView.reloadData()
        getUserDetails()
        indexingValue.questionType.removeAll()
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
                    self.bookingHistoryTblView.isHidden = true
                    self.clieckHere_Btn.isHidden = false
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
                    let doctInfo = allDoctorInfo.docotrDetails(patient_id: specialistObj["patient_id"] as? Int, doctor_id: specialistObj["doctor_id"] as? Int, from: specialistObj["from"] as? String, froms: (specialistObj["froms"] as? String)!, to: (specialistObj["to"] as? String)!, id: doctorDetails["id"] as? Int, name: doctorDetails["name"] as? String, type: doctorDetails["type"] as? Int, avatar: doctorDetails["avatar"] as? String, specialist: doctorDetails["specialist"] as? String, created_at: doctorDetails["created_at"] as? String, updated_at: doctorDetails["updated_at"] as? String)
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
                        self.doctorInfoArr.append(doctInfo)
                    }
                    print(self.doctorInfoArr)
                    self.bookingHistoryTblView.reloadData()
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
    
    func complaintQuestionNaireApi(){
        LoadingIndicatorView.show()
        let api = Configurator.baseURL + ApiEndPoints.complaintquestions
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                LoadingIndicatorView.hide()
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
                            print(indexingValue.questionType)
                            indexingValue.indexValue = 0
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
        //complaintQuestionNaireApi()
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "AvailableDoctorsViewController") as! AvailableDoctorsViewController
       // obj.whtsAppIcon = "whtsAppIcon"
        self.navigationController?.pushViewController(obj, animated: true)
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

extension HomeViewController : UITableViewDelegate{
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

