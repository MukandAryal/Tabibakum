//
//  MenuViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 27/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class MenuViewController: BaseClassViewController {
    
    @IBOutlet weak var menuTblView: UITableView!
    var questionListArr = [String:AnyObject]()
    static var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    let patientMenuBarItem = ["BOOKINGS","HISTORY","NOTIFICATION","UPDATE QUESTIONNAIRE","PROFILE SETTING"]
    
    var patientMenuBarICon: [UIImage] = [
        UIImage(named: "booking_nav_dark.png")!,
        UIImage(named: "history.png")!,UIImage(named: "notification.png")!,UIImage(named: "updateQuestionNaire.png")!,UIImage(named: "ProfileSetting.png")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibHeaderName = UINib(nibName: "menuHeaderView", bundle: nil)
        menuTblView.register(nibHeaderName, forHeaderFooterViewReuseIdentifier: "menuHeaderView")
        
        menuTblView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        menuTblView.tableFooterView = UIView()
        
    }
    
    func questionNaireApi(){
       self.showCustomProgress()
        let api = Configurator.baseURL + ApiEndPoints.patientquestion
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                self.stopProgress()
            //    print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let type = specialistObj["type"] as? String
                    indexingValue.questionType.append(type!)
                    let id = specialistObj["id"] as? Int
                    self.questionListArr["value"] = type as AnyObject
                    self.questionListArr["id"] = id as AnyObject
                    indexingValue.newBookingQuestionListArr.append(self.questionListArr)
                    print("questionList>>>>>>",indexingValue.newBookingQuestionListArr)
                    indexingValue.indexCount = 0
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    @IBAction func actionSingOutBtn(_ sender: Any) {
        print("signOut")
        
        self.logoutView()
        
    }
}

extension MenuViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = menuTblView.dequeueReusableHeaderFooterView(withIdentifier: "menuHeaderView" ) as! menuHeaderView
        let imgStr = UserDefaults.standard.string(forKey: "loginUserProfileImage")
        let nameStr = UserDefaults.standard.string(forKey: "loginUserName")
        headerView.userImg_view.sd_setImage(with: URL(string: imgStr!), placeholderImage: UIImage(named: "user_pic"))
        headerView.userName_lbl.text = nameStr
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientMenuBarItem.count
    }
    // UiInterFace.appThemeColor
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.menuBar_Lbl.text = patientMenuBarItem[indexPath.row]
        cell.menuBar_Img.image = patientMenuBarICon[indexPath.row]
        if  indexPath == MenuViewController.selectedIndexPath {
            cell.contentView.backgroundColor = UiInterFace.appThemeColor
            cell.menuBar_Lbl.textColor = UIColor.white
            cell.menuBar_Img?.tintColor = UIColor.white
        }else{
            cell.contentView.backgroundColor = UIColor.white
            cell.menuBar_Lbl.textColor = UIColor.black
            cell.menuBar_Img?.tintColor = UIColor.black
        }
        return cell
    }
}

extension MenuViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? MenuTableViewCell {
            selectedCell.contentView.backgroundColor = UiInterFace.appThemeColor
            selectedCell.menuBar_Lbl.textColor = UIColor.white
            selectedCell.menuBar_Img?.tintColor = UIColor.white
            MenuViewController.selectedIndexPath = indexPath
            
        }
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
            indexingValue.questionNaireType = "updateQuestionNaire"
            questionNaireApi()
        }
        else if indexPath.row == 4{
            let profilesettingObj = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettingViewController") as! ProfileSettingViewController
            self.navigationController?.pushViewController(profilesettingObj, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        cell.contentView.backgroundColor = UiInterFace.tabBackgroundColor
        cell.menuBar_Lbl.textColor = UIColor.black
        cell.menuBar_Img?.tintColor = UIColor.black

    }
}
