//
//  NotificationPatientViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 28/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire

struct allNotificationInfo {
    struct notificationDetails {
        var id : Int
        var user_id : Int
        var title : String
        var description : String
        var created_at : String
    }
    var notificationInfo : [allNotificationInfo]
}

class NotificationPatientViewController: UIViewController {
    @IBOutlet weak var notificationTblView: UITableView!
    @IBOutlet weak var clearNotification_View: UIView!
    @IBOutlet var mainView: UIView!
    var notificationInfoArr = [allNotificationInfo.notificationDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setDefaults()
        notificationTblView.register(UINib(nibName: "NotificationPatientTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationPatientTableViewCell")
        clearNotification_View.layer.cornerRadius = 20
        clearNotification_View.clipsToBounds = true
        clearNotification_View.isHidden = true
        notoificationApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func overlayBlurredBackgroundView() {
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        
        view.addSubview(blurredBackgroundView)
        
    }
    
    func removeBlurredBackgroundView() {
        
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
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
    
    func notoificationApi(){
        LoadingIndicatorView.show()
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let api = Configurator.baseURL + ApiEndPoints.notification + "?id=\(userId)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let notiInfo = allNotificationInfo.notificationDetails(id: (specialistObj["id"] as? Int)!, user_id: (specialistObj["user_id"] as? Int)!, title: (specialistObj["title"] as? String)!, description: (specialistObj["description"] as? String)!, created_at: (specialistObj["created_at"] as? String)!)
                    self.notificationInfoArr.append(notiInfo)
                    print(self.notificationInfoArr)
                    LoadingIndicatorView.hide()
                    self.notificationTblView.reloadData()
                }
        }
    }
    
    @IBAction func actionDeleteBtn(_ sender: Any) {
        mainView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        // clearNotification_View.backgroundColor = UIColor.white
        clearNotification_View.isHidden = false
    }
}

extension NotificationPatientViewController : UITableViewDataSource{
    
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

extension NotificationPatientViewController : UITableViewDelegate{
    
}

