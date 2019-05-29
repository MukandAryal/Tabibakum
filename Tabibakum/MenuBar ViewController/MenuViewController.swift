//
//  MenuViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 27/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuTblView: UITableView!
    let menuBarItem = ["BOOKINGS","HISTORY","NOTIFICATION","UPDATE QUESTIONNAIRE","PROFILE SETTING"]

    
    var menuBarICon: [UIImage] = [
        UIImage(named: "booking_nav_dark.png")!,
        UIImage(named: "history.png")!,UIImage(named: "notification.png")!,UIImage(named: "updateQuestionNaire.png")!,UIImage(named: "ProfileSetting.png")!]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibHeaderName = UINib(nibName: "menuHeaderView", bundle: nil)
        menuTblView.register(nibHeaderName, forHeaderFooterViewReuseIdentifier: "menuHeaderView")
        
        menuTblView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        menuTblView.tableFooterView = UIView()
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
        return menuBarItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.menuBar_Lbl.text = menuBarItem[indexPath.row]
        cell.menuBar_Img.image = menuBarICon[indexPath.row] 
        
        return cell
    }
}

extension MenuViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let bookingObj = self.storyboard?.instantiateViewController(withIdentifier: "BookingsPatientViewController") as! BookingsPatientViewController
            self.navigationController?.pushViewController(bookingObj, animated: true)
            
        }else if indexPath.row == 1 {
            let historyObj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
           self.navigationController?.pushViewController(historyObj, animated: true)
            
        }else if indexPath.row == 2{
            let notificationObj = self.storyboard?.instantiateViewController(withIdentifier: "NotificationPatientViewController") as! NotificationPatientViewController
            self.navigationController?.pushViewController(notificationObj, animated: true)
        }else if indexPath.row == 3{
            let reviewObj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileSettingViewController") as! DoctorProfileSettingViewController
            self.navigationController?.pushViewController(reviewObj, animated: true)
        }
        else if indexPath.row == 4{
            let profilesettingObj = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettingViewController") as! ProfileSettingViewController
            self.navigationController?.pushViewController(profilesettingObj, animated: true)
        }
        
    }
    
}
