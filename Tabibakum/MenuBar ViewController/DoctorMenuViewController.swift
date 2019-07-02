//
//  DoctorMenuViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 02/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire
import SideMenu

class DoctorMenuViewController: UIViewController {
    
    @IBOutlet weak var menuTblView: UITableView!
    
    let patientMenuBarItem = ["BOOKINGS","HISTORY","NOTIFICATION","UPDATE QUESTIONNAIRE","PROFILE SETTING"]
    
    var patientMenuBarICon: [UIImage] = [
        UIImage(named: "booking_nav_dark.png")!,
        UIImage(named: "history.png")!,UIImage(named: "notification.png")!,UIImage(named: "updateQuestionNaire.png")!,UIImage(named: "ProfileSetting.png")!]
    
    let doctorMenuBarItem = ["BOOKINGS","HISTORY","SCHEDULE SLOT","NOTIFICATION","UPDATE QUESTIONNAIRE","REVIEWS","PROFILE SETTING"]
    
    var doctorMenuBarICon: [UIImage] = [
        UIImage(named: "booking_nav_dark.png")!,
        UIImage(named: "history.png")!,UIImage(named: "notification.png")!,UIImage(named: "booking_nav_dark.png")!,UIImage(named: "updateQuestionNaire.png")!,UIImage(named: "booking_nav_dark.png")!,UIImage(named: "ProfileSetting.png")!]
    
    var loginType = Int()
    var imageStr = String()
    var userName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetails()
        let nibHeaderName = UINib(nibName: "menuHeaderView", bundle: nil)
        menuTblView.register(nibHeaderName, forHeaderFooterViewReuseIdentifier: "menuHeaderView")
        
        menuTblView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        menuTblView.tableFooterView = UIView()
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
    
    func getUserDetails(){
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        // LoadingIndicatorView.show()
        let api = Configurator.baseURL + ApiEndPoints.user_details + "?token=\(loginToken ?? "")"
        
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                // LoadingIndicatorView.hide()
                let resultDict = response.value as? NSDictionary
                let userDetails = resultDict!["user"] as? NSDictionary
                self.loginType = userDetails?.object(forKey: "type") as! Int
                let img =  userDetails?.object(forKey: "avatar") as? String
                self.imageStr = Configurator.imageBaseUrl + img!
                self.userName = (userDetails?.object(forKey: "name") as? String)!
                self.menuTblView.reloadData()
        }
    }
    
    func questionNaireApi(){
        LoadingIndicatorView.show()
        let api = Configurator.baseURL + ApiEndPoints.doctorquestion
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                LoadingIndicatorView.hide()
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let type = specialistObj["type"] as? String
                    indexingValue.questionType.append(type!)
                    print(indexingValue.questionType)
                    indexingValue.indexValue = 0
                }
                if indexingValue.questionType[indexingValue.indexValue] == "text"{
                    print("text")
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireTextViewController")as! QuestionNaireTextViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                }else if indexingValue.questionType[indexingValue.indexValue] == "yesno"{
                    print("yes")
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionYesNoViewController")as! QuestionYesNoViewController
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
                indexingValue.indexValue = +1
        }
    }
}

extension DoctorMenuViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = menuTblView.dequeueReusableHeaderFooterView(withIdentifier: "menuHeaderView" ) as! menuHeaderView
        headerView.userImg_view.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        headerView.userName_lbl.text = userName
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorMenuBarICon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.menuBar_Lbl.text = doctorMenuBarItem[indexPath.row]
        cell.menuBar_Img.image = doctorMenuBarICon[indexPath.row]
        return cell
    }
}

extension DoctorMenuViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorHomeViewController") as! DoctorHomeViewController
            self.navigationController?.pushViewController(bookingObj, animated: true)
        }else if indexPath.row == 1 {
            let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "BookingsDoctorViewController") as! BookingsDoctorViewController
            self.navigationController?.pushViewController(bookingObj, animated: true)
        }else if indexPath.row == 2 {
            let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleBookingViewController") as! ScheduleBookingViewController
            self.navigationController?.pushViewController(bookingObj, animated: true)
        }else if indexPath.row == 3{
            let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorNotificationViewController") as! DoctorNotificationViewController
            self.navigationController?.pushViewController(bookingObj, animated: true)
        }else if indexPath.row == 4{
            questionNaireApi()
        }else if indexPath.row == 5{
            let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorReviewViewController") as! DoctorReviewViewController
            self.navigationController?.pushViewController(bookingObj, animated: true)
        }else {
            let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileSettingViewController") as! DoctorProfileSettingViewController
            self.navigationController?.pushViewController(bookingObj, animated: true)
        }
    }
}

