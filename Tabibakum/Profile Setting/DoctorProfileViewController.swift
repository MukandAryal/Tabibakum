//
//  DoctorProfileViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 30/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire
import Cosmos

struct doctorFeedbackInfo {
    struct feedbackDetails {
        var avatar : String
        var created_at : String
        var doctor_id  : Int
        var feedback : String
        var id : Int
        var patient_name : String
        var patient_id : Int
        var rating : Int
    }
    var feedbackInfo : [doctorFeedbackInfo]
}

class DoctorProfileViewController: BaseClassViewController,UITextViewDelegate {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var mainViewHeightCon: NSLayoutConstraint!
    var doctorId : Int?
    @IBOutlet weak var profile_ImgView: UIImageView!
    @IBOutlet weak var info_view: UIView!
    @IBOutlet weak var bookAppoinment_Btn: UIButton!
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var appointment_view: UIView!
    @IBOutlet weak var profile_Btn: UIButton!
    @IBOutlet weak var feedback_Btn: UIButton!
    @IBOutlet weak var feedTblView: UITableView!
    @IBOutlet weak var addFeedback_Btn: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var date_VIew: UIView!
    @IBOutlet weak var time_View: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var addFeedback_View: UIView!
    @IBOutlet weak var enterFeedBack_View: UIView!
    @IBOutlet weak var addFeedbackBtn_Constraints: NSLayoutConstraint!
    
    @IBOutlet weak var profileViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var name_Lbl: UILabel!
    @IBOutlet weak var education_Lbl: UILabel!
    @IBOutlet weak var experience_Lbl: UILabel!
    @IBOutlet weak var gender_Lbl: UILabel!
    @IBOutlet weak var appointmentDate_Lbl: UILabel!
    @IBOutlet weak var appointmentTime_Lbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var specialist_Lbl: UILabel!
    @IBOutlet weak var whtsApp_Icon: UIImageView!
    @IBOutlet weak var connectWhtsApp_Btn: UIButton!
    @IBOutlet weak var bookAppointmentBtnHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var infoViewHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var bookAppointmentConstraints: NSLayoutConstraint!
    @IBOutlet weak var addfeedback: NSLayoutConstraint!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var feedBackHeight: NSLayoutConstraint!
    @IBOutlet weak var connectHeight: NSLayoutConstraint!
    @IBOutlet weak var rating_descriptionLbl: UITextView!
    var type_str = String()
    var feedBackArr = [doctorFeedbackInfo.feedbackDetails]()
    var doctorInfoDetailsArr = allDoctorList.doctorDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("doctorInfoDetailsArr>>",doctorInfoDetailsArr)
        profile_ImgView.layer.cornerRadius = profile_ImgView.frame.height/2
        profile_ImgView.clipsToBounds = true
        bookAppoinment_Btn.layer.cornerRadius = bookAppoinment_Btn.frame.height/2
        bookAppoinment_Btn.clipsToBounds = true
        date_VIew.layer.borderColor = UIColor.lightGray.cgColor
        date_VIew.layer.borderWidth = 0.5
        date_VIew.layer.cornerRadius = 10
        date_VIew.clipsToBounds = true
        time_View.layer.borderWidth = 0.5
        time_View.layer.borderColor = UIColor.lightGray.cgColor
        time_View.layer.borderWidth = 0.5
        time_View.layer.cornerRadius = 10
        time_View.clipsToBounds = true
        connectBtn.layer.cornerRadius = connectBtn.frame.height/2
        connectBtn.clipsToBounds = true
        profile_Btn.layer.borderColor = UIColor(red: 66/254, green: 153/254, blue: 52/254, alpha: 1.0).cgColor
        profile_Btn.layer.borderWidth = 1
        profile_Btn.roundedButton()
        feedback_Btn.roundedButton1()
        feedback_Btn.layer.borderColor =  UIColor(red: 66/254, green: 153/254, blue: 52/254, alpha: 1.0).cgColor
        feedback_Btn.layer.borderWidth = 1
        addFeedback_Btn.layer.borderColor = UIColor(red: 66/254, green: 153/254, blue: 52/254, alpha: 1.0).cgColor
        addFeedback_Btn.layer.borderWidth = 0.5
        addFeedback_Btn.layer.cornerRadius = addFeedback_Btn.frame.height/2
        addFeedback_Btn.clipsToBounds = true
        feedTblView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        feedbackView.isHidden = true
        addFeedback_View.layer.borderColor = UIColor.lightGray.cgColor
        addFeedback_View.layer.borderWidth = 0.5
        addFeedback_View.layer.cornerRadius = 10
        addFeedback_View.clipsToBounds = true
        enterFeedBack_View.layer.borderColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        enterFeedBack_View.layer.borderWidth = 1
        enterFeedBack_View.layer.cornerRadius = 10
        enterFeedBack_View.clipsToBounds = true
        addFeedback_View.isHidden = true
        
        rating_descriptionLbl.delegate = self
        rating_descriptionLbl.text = "Enter Feedback"
        rating_descriptionLbl.textColor = UIColor.lightGray
        bookAppoinment_Btn.backgroundColor = UiInterFace.appThemeColor
        name_Lbl.text = doctorInfoDetailsArr.name
        if let imageStr = doctorInfoDetailsArr.avatar{
            let imgStr = Configurator.imageBaseUrl + imageStr
            self.profile_ImgView.sd_setImage(with: URL(string: imgStr), placeholderImage: UIImage(named: "user_pic"))
        }
        specialist_Lbl.text = doctorInfoDetailsArr.specialist
        description_Lbl.text = doctorInfoDetailsArr.description
        education_Lbl.text = doctorInfoDetailsArr.education
        experience_Lbl.text = doctorInfoDetailsArr.experience
        gender_Lbl.text = doctorInfoDetailsArr.gender
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        info_view.layer.borderWidth = 0.5
        info_view.layer.borderColor = UIColor.gray.cgColor
        info_view.layer.cornerRadius = 5
        userProfileApi()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupProfile(descString : String){
        if type_str == "whtsApp"{
            appointment_view.isHidden = true
            bookAppoinment_Btn.isHidden = true
            whtsApp_Icon.isHidden = false
            connectHeight.constant = 40
            
            infoViewHeightConstrains.constant = (descString.height(withConstrainedWidth: self.view.frame.size.width-30, font: UIFont.systemFont(ofSize: 13.0))) + 230
            
            info_view.addConstraint(infoViewHeightConstrains)
            
            profileViewHeight.constant = infoViewHeightConstrains.constant
            profileView.addConstraint(profileViewHeight)
            
        }else if type_str == "appointment"{
            whtsApp_Icon.isHidden = true
            connectHeight.constant = 0
            bookAppoinment_Btn.isHidden = true
            appointment_view.isHidden = false
            bookAppointmentBtnHeightConstrains.constant = 0
            infoViewHeightConstrains.constant = (descString.height(withConstrainedWidth: self.view.frame.size.width-30, font: UIFont.systemFont(ofSize: 13.0))) + 160
            
            info_view.addConstraint(infoViewHeightConstrains)
            profileViewHeight.constant = infoViewHeightConstrains.constant + appointment_view.frame.size.height
            
        }else{
            whtsApp_Icon.isHidden = true
            appointment_view.isHidden = true
            bookAppoinment_Btn.isHidden = false
            bookAppointmentBtnHeightConstrains.constant = 40
            connectHeight.constant = 0
            bookAppointmentConstraints.constant = 20
            infoViewHeightConstrains.constant = (descString.height(withConstrainedWidth: self.view.frame.size.width-30, font: UIFont.systemFont(ofSize: 13.0))) + 160
            info_view.addConstraint(infoViewHeightConstrains)
            profileViewHeight.constant = infoViewHeightConstrains.constant + 60
            
        }
    }
    
    func setupFeedBack(tableRows : Int){
        
        self.addFeedback_View.isHidden = true
        self.addFeedback_Btn.isHidden = false
        
        if tableRows == 0 {
            self.tableHeight.constant = 0
            self.feedTblView.addConstraint(self.tableHeight)
            feedBackHeight.constant = 50
        }
        else if tableRows < 4 {
            self.tableHeight.constant = CGFloat(tableRows*80)
            self.feedTblView.addConstraint(self.tableHeight)
            profileViewHeight.constant = CGFloat(tableRows*80) + 100
            self.feedTblView.reloadData()
        }
        else{
            self.tableHeight.constant = 4*80
            self.feedTblView.addConstraint(self.tableHeight)
            profileViewHeight.constant = CGFloat(4*80) + 100
            self.feedTblView.reloadData()
        }
    }
    
    func userProfileApi(){
        self.showCustomProgress()
        let api = Configurator.baseURL + ApiEndPoints.userdata + "?user_id=\(doctorId ?? 0)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.stopProgress()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for userData in dataDict! {
                    if let imageStr = userData["avatar"] as? String{
                        let imgStr = Configurator.imageBaseUrl + imageStr
                        self.profile_ImgView.sd_setImage(with: URL(string: imgStr), placeholderImage: UIImage(named: "user_pic"))
                    }
                    self.name_Lbl.text = userData["name"] as? String
                    self.specialist_Lbl.text = userData["specialist"] as? String
                    self.description_Lbl.text = userData["description"] as? String
                    self.education_Lbl.text = userData["education"] as? String
                    self.experience_Lbl.text = userData["experience"] as? String
                    self.gender_Lbl.text = userData["gender"] as? String
                    self.setupProfile(descString: self.description_Lbl.text!)
                }
                for userData in dataDict! {
                    let feedbackData = userData["doctor_feedback"] as? [[String:AnyObject]]
                    for feedbackObj in feedbackData! {
                        let feedbackInfo = doctorFeedbackInfo.feedbackDetails(avatar: (feedbackObj["avatar"] as? String)!, created_at: (feedbackObj["created_at"] as? String)!, doctor_id: (feedbackObj["doctor_id"] as? Int)!, feedback: (feedbackObj["feedback"] as? String)!, id: (feedbackObj["id"] as? Int)!, patient_name: (feedbackObj["patient_name"] as? String)!, patient_id: (feedbackObj["patient_id"] as? Int)!, rating: (feedbackObj["rating"] as? Int)!)
                        self.feedBackArr.append(feedbackInfo)
                    }
                }
        }
    }
    
    func feedbackApi(){
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        self.showCustomProgress()
        let param: [String: AnyObject] = [
            "feedback" : rating_descriptionLbl.text! as AnyObject,
            "rating" : cosmosView?.rating as AnyObject,
            "doctor_id" : (doctorId?.description)! as AnyObject,
            "token" : loginToken! as AnyObject
        ]
        
        print(param)
        
        let api = Configurator.baseURL + ApiEndPoints.feedback_post
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.stopProgress()
                var resultDict = response.value as? [String:Bool]
                if resultDict!["success"]!  {
                    print("success")
                    self.addFeedbackBtn_Constraints.constant = 40
                    
                    self.feedTblView.reloadData()
                    self.rating_descriptionLbl.text = ""
                    //self.userProfileApi()
                }else{
                    print("failure")
                }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Feedback"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionBookApointmentBtn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "BookAppoinmentViewController") as? BookAppoinmentViewController
        obj?.doctorId = doctorId!.description
        self.navigationController?.pushViewController(obj!, animated: true)
    }
    
    @IBAction func actionProfileBtn(_ sender: Any) {
        setupProfile(descString: description_Lbl.text!)
        profileView.isHidden = false
        feedbackView.isHidden = true
        feedback_Btn.backgroundColor = UIColor.white
        profile_Btn.backgroundColor =  UIColor(red: 188/254, green: 227/254, blue: 182/254, alpha: 1.0)
    }
    
    @IBAction func actionFeedbackTab(_ sender: Any) {
        
        profileView.isHidden    = true
        feedbackView.isHidden   = false
        
        profile_Btn.backgroundColor = UIColor.white
        feedback_Btn.backgroundColor =  UIColor(red: 188/254, green: 227/254, blue: 182/254, alpha: 1.0)
        setupFeedBack(tableRows: self.feedBackArr.count)
        
    }
    @IBAction func actionAddFeedBackBtn(_ sender: Any) {
        
        addFeedback_View.isHidden = false
        addFeedback_Btn.isHidden = true
        profileViewHeight.constant = profileViewHeight.constant + 130
    }
    
    @IBAction func actionCancelBtn(_ sender: Any) {
        addFeedback_View.isHidden = true
        addFeedback_Btn.isHidden = false
        profileViewHeight.constant = profileViewHeight.constant - 130
    }
    
    @IBAction func actionSubmitBtn(_ sender: Any) {
        addFeedback_View.isHidden = true
        addFeedback_Btn.isHidden = false
        profileViewHeight.constant = profileViewHeight.constant - 130
        feedbackApi()
    }
}

extension DoctorProfileViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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

extension DoctorProfileViewController : UITableViewDelegate{
    
}

extension UIButton{
    func roundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft ,],
                                     cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
extension UIButton{
    func roundedButton1(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight],
                                     cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
