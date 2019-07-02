//
//  DoctorNotificationViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 02/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire

class DoctorNotificationViewController: UIViewController {
    @IBOutlet weak var notificationTblView: UITableView!
    @IBOutlet weak var clearNotification_View: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var delete_Btn: UIButton!
    @IBOutlet weak var no_notificationImg: UIImageView!
    @IBOutlet weak var no_newNotificationLbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!
    var notificationInfoArr = [allNotificationInfo.notificationDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setDefaults()
        notificationTblView.register(UINib(nibName: "NotificationPatientTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationPatientTableViewCell")
        clearNotification_View.layer.cornerRadius = 20
        clearNotification_View.clipsToBounds = true
        clearNotification_View.isHidden = true
        delete_Btn.isHidden = true
        self.no_notificationImg.isHidden = true
        self.no_newNotificationLbl.isHidden = true
        self.description_Lbl.isHidden = true
        description_Lbl.text = "We'll let you know when we've got sumthing new for \nyou"
        notoificationApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        let loginType = UserDefaults.standard.integer(forKey: "loginType")
        if loginType == 0 {
            SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        }else{
            SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "DocotorLeftMenuNavigationController") as? UISideMenuNavigationController
        }
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setDefaults() {
        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .menuDissolveIn]
        
    }
    
    func notoificationApi(){
        LoadingIndicatorView.show()
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let api = Configurator.baseURL + ApiEndPoints.notification + "?id=\(userId)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                LoadingIndicatorView.hide()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let notiInfo = allNotificationInfo.notificationDetails(id: (specialistObj["id"] as? Int)!, user_id: (specialistObj["user_id"] as? Int)!, title: (specialistObj["title"] as? String)!, description: (specialistObj["description"] as? String)!, created_at: (specialistObj["created_at"] as? String)!)
                    self.notificationInfoArr.append(notiInfo)
                    self.delete_Btn.isHidden = false
                    self.notificationTblView.reloadData()
                }
                self.notificationTblView.isHidden = true
                self.no_notificationImg.isHidden = false
                self.no_newNotificationLbl.isHidden = false
                self.description_Lbl.isHidden = false
        }
    }
    
    @IBAction func actionNotificationBtn(_ sender: Any) {
        let loginType = UserDefaults.standard.integer(forKey: "loginType")
        if loginType == 0 {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.present(obj, animated: true, completion: nil)
        }else{
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorHomeViewController") as! DoctorHomeViewController
            self.present(obj, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func actionDeleteBtn(_ sender: Any) {
        mainView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        clearNotification_View.isHidden = false
    }
}

extension DoctorNotificationViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationPatientTableViewCell") as! NotificationPatientTableViewCell
        cell.notification_NameLbl.text = notificationInfoArr[indexPath.row].title
        cell.notification_DescriptionLbl.text = notificationInfoArr[indexPath.row].description
        cell.notification_DateLbl.text = notificationInfoArr[indexPath.row].created_at.prefix(10).description
        return cell
    }
}

extension DoctorNotificationViewController : UITableViewDelegate{
    
}

