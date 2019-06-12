//
//  MenuViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 27/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class MenuViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetails()
        let nibHeaderName = UINib(nibName: "menuHeaderView", bundle: nil)
        menuTblView.register(nibHeaderName, forHeaderFooterViewReuseIdentifier: "menuHeaderView")
        
        menuTblView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        menuTblView.tableFooterView = UIView()
        
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
                print(self.loginType)
                self.menuTblView.reloadData()
        }
    }
}

extension MenuViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = menuTblView.dequeueReusableHeaderFooterView(withIdentifier: "menuHeaderView" ) as! menuHeaderView
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loginType == 0 {
            return patientMenuBarItem.count
        }else{
            return doctorMenuBarICon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        if loginType == 0 {
        cell.menuBar_Lbl.text = patientMenuBarItem[indexPath.row]
        cell.menuBar_Img.image = patientMenuBarICon[indexPath.row]
        }else{
            cell.menuBar_Lbl.text = doctorMenuBarItem[indexPath.row]
            cell.menuBar_Img.image = doctorMenuBarICon[indexPath.row]
        }
        return cell
    }
}

extension MenuViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if loginType == 0{
        if indexPath.row == 0 {
            let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(bookingObj, animated: true)
            
        }else if indexPath.row == 1 {
            let historyObj = self.storyboard?.instantiateViewController(withIdentifier: "BookingsPatientViewController") as! BookingsPatientViewController
           self.navigationController?.pushViewController(historyObj, animated: true)
            
        }else if indexPath.row == 2{
            let notificationObj = self.storyboard?.instantiateViewController(withIdentifier: "NotificationPatientViewController") as! NotificationPatientViewController
            self.navigationController?.pushViewController(notificationObj, animated: true)
        }else if indexPath.row == 3{
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "singUpPatientWelcomeScreenViewController") as? singUpPatientWelcomeScreenViewController
            self.navigationController?.pushViewController(obj!, animated: true)
//            let reviewObj = self.storyboard?.instantiateViewController(withIdentifier: "ListQuestionNaireViewController") as! ListQuestionNaireViewController
//            self.navigationController?.pushViewController(reviewObj, animated: true)
        }
        else if indexPath.row == 4{
            let profilesettingObj = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettingViewController") as! ProfileSettingViewController
            self.navigationController?.pushViewController(profilesettingObj, animated: true)
        }
        }else{
            if indexPath.row == 0 {
                let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(bookingObj, animated: true)
            }else if indexPath.row == 1 {
                let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "BookingsPatientViewController") as! BookingsPatientViewController
                self.navigationController?.pushViewController(bookingObj, animated: true)
            }else if indexPath.row == 2 {
                
            }else if indexPath.row == 3{
                let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "NotificationPatientViewController") as! NotificationPatientViewController
                self.navigationController?.pushViewController(bookingObj, animated: true)
            }else if indexPath.row == 4{
                
            }else if indexPath.row == 5{
                
            }else {
                let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileSettingViewController") as! DoctorProfileSettingViewController
                self.navigationController?.pushViewController(bookingObj, animated: true)
            }
        }
    }
}
