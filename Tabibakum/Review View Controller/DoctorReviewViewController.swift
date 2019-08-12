//
//  DoctorReviewViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 02/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import Cosmos

class DoctorReviewViewController: BaseClassViewController {
    
    @IBOutlet weak var userProfile_ImgView: UIImageView!
    @IBOutlet weak var rating_view: CosmosView!
    @IBOutlet weak var userName_Lbl: UILabel!
    @IBOutlet weak var reviewTblView: UITableView!
    var feedBackArr = [doctorFeedbackInfo.feedbackDetails]()
    var ratingStr = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTblView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        self.rating_view.rating = 1
        userProfileApi()
        userProfile_ImgView.layer.cornerRadius = userProfile_ImgView.frame.height/2
        userProfile_ImgView.clipsToBounds = true
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setDefaults() {
        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .menuDissolveIn]
        
    }
    
    func userProfileApi(){
        let useid = UserDefaults.standard.integer(forKey: "userId")
        self.showCustomProgress()
        let api = Configurator.baseURL + ApiEndPoints.userdata + "?user_id=\(useid)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
             //   print(response)
                self.stopProgress()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                self.ratingStr = 0
                for userData in dataDict! {
                    self.userName_Lbl.text = userData["name"] as? String
                    let img = userData["avatar"] as? String
                    let imageStr = Configurator.imageBaseUrl + img!
                    self.userProfile_ImgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
                    let feedbackData = userData["doctor_feedback"] as? [[String:AnyObject]]
                    for feedbackObj in feedbackData! {
                        let feedbackInfo = doctorFeedbackInfo.feedbackDetails(avatar: (feedbackObj["avatar"] as? String)!, created_at: (feedbackObj["created_at"] as? String)!, doctor_id: (feedbackObj["doctor_id"] as? Int)!, feedback: (feedbackObj["feedback"] as? String)!, id: (feedbackObj["id"] as? Int)!, patient_name: (feedbackObj["patient_name"] as? String)!, patient_id: (feedbackObj["patient_id"] as? Int)!, rating: (feedbackObj["rating"] as? Int)!)
                        
                        self.ratingStr  = feedbackInfo.rating + self.ratingStr
                        print(self.ratingStr)
                        self.feedBackArr.append(feedbackInfo)
                        
                    }
                    print(self.ratingStr)
                    self.rating_view.rating = Double(self.ratingStr/self.feedBackArr.count)
                    self.reviewTblView.reloadData()
                }
        }
    }
}

extension DoctorReviewViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedBackArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as! ReviewTableViewCell
        let img =  feedBackArr[indexPath.row].avatar
        let imageStr = Configurator.imageBaseUrl + img
        cell.profile_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        cell.name_Lbl.text = feedBackArr[indexPath.row].patient_name
        cell.description_Lbl.text = feedBackArr[indexPath.row].feedback
        cell.date_Lbl.text = feedBackArr[indexPath.row].created_at.prefix(11).description
        cell.star_View.rating = Double(feedBackArr[indexPath.row].rating)
        return cell
    }
    
}

extension DoctorReviewViewController : UITableViewDelegate{
    
}

