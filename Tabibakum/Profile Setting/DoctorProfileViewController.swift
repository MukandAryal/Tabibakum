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

class DoctorProfileViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var mainViewHeightCon: NSLayoutConstraint!
    
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
    
    @IBOutlet weak var rating_descriptionLbl: UITextView!
    var whtsAppIcon = String()
    var appoinotmentDetails = String()
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
       // userProfileApi()
        rating_descriptionLbl.delegate = self
        rating_descriptionLbl.text = "Enter Feedback"
        rating_descriptionLbl.textColor = UIColor.lightGray
        bookAppoinment_Btn.backgroundColor = UiInterFace.appThemeColor
        name_Lbl.text = doctorInfoDetailsArr.name
        let imageStr = Configurator.imageBaseUrl + doctorInfoDetailsArr.avatar!
        self.profile_ImgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        specialist_Lbl.text = doctorInfoDetailsArr.specialist
        description_Lbl.text = doctorInfoDetailsArr.description
        education_Lbl.text = doctorInfoDetailsArr.education
        experience_Lbl.text = doctorInfoDetailsArr.experience
        gender_Lbl.text = doctorInfoDetailsArr.gender
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // info_view.layer.shadowColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        //info_view.layer.shadowOpacity = 1
       // info_view.layer.shadowOffset = .zero
      //  info_view.layer.shadowRadius = 10
        info_view.layer.borderWidth = 0.5
        info_view.layer.borderColor = UIColor.gray.cgColor
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.info_view.frame
        rectShape.position = self.info_view.center
       rectShape.path = UIBezierPath(roundedRect: self.info_view.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
       self.info_view.layer.mask = rectShape
        
       // self.info_view.layer.borderColor = UIColor.red.cgColor
       // self.info_view.layer.borderWidth = 1
        self.info_view.layer.cornerRadius = 5
        if whtsAppIcon == "whtsAppIcon"{
            appointment_view.isHidden = true
            bookAppoinment_Btn.isHidden = true
        }else if appoinotmentDetails == "appoinotmentDetails"{
            whtsApp_Icon.isHidden = true
            connectBtn.isHidden = true
            appointment_view.isHidden = false
            bookAppointmentBtnHeightConstrains.constant = 0
            infoViewHeightConstrains.constant = 260
        }else{
            whtsApp_Icon.isHidden = true
            connectBtn.isHidden = true
            infoViewHeightConstrains.constant = 260
            bookAppointmentBtnHeightConstrains.constant = 40
            appointment_view.isHidden = true
            bookAppointmentConstraints.constant = 20
        }
    }
    
    func userProfileApi(){
        LoadingIndicatorView.show()
        let api = Configurator.baseURL + ApiEndPoints.userdata + "?user_id=\(doctorInfoDetailsArr.id ?? 0)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                LoadingIndicatorView.hide()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                 print(dataDict)
                for userData in dataDict! {
                    let feedbackData = userData["doctor_feedback"] as? [[String:AnyObject]]
                    for feedbackObj in feedbackData! {
                        let feedbackInfo = doctorFeedbackInfo.feedbackDetails(avatar: (feedbackObj["avatar"] as? String)!, created_at: (feedbackObj["created_at"] as? String)!, doctor_id: (feedbackObj["doctor_id"] as? Int)!, feedback: (feedbackObj["feedback"] as? String)!, id: (feedbackObj["id"] as? Int)!, patient_name: (feedbackObj["patient_name"] as? String)!, patient_id: (feedbackObj["patient_id"] as? Int)!, rating: (feedbackObj["rating"] as? Int)!)
                        self.feedBackArr.append(feedbackInfo)
                        self.feedTblView.reloadData()
                        print(self.feedBackArr)
                    }
                }
          }
    }
    
    func feedbackApi(){
        LoadingIndicatorView.show()
        let param: [String: String] = [
            "feedback" : rating_descriptionLbl.text!,
            "rating" : "3",
            "doctor_id" : "310",
            "token" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMjQuMjcuMjU1OjgwMDBcL2FwaVwvbG9naW4iLCJpYXQiOjE1NTk4OTg5NzksImV4cCI6MTU2MTEwODU3OSwibmJmIjoxNTU5ODk4OTc5LCJqdGkiOiJFckZNTE91Y2VjNld4c1JMIiwic3ViIjozMTEsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.RgLk5jh36iGrWy2mQ0z7_i0LJC7QMaGrZSMFSmHg2MU"
        ]
        
        print(param)
        
        let api = Configurator.baseURL + ApiEndPoints.feedback_post
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                LoadingIndicatorView.hide()
                var resultDict = response.value as? [String:Bool]
                if resultDict!["success"]!  {
                     print("success")
                    self.addFeedbackBtn_Constraints.constant = 40
                    self.addFeedback_Btn.isHidden = false
                    self.addFeedback_View.isHidden = true
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
        obj?.doctorId = (doctorInfoDetailsArr.id?.description)!
        self.navigationController?.pushViewController(obj!, animated: true)
    }
    
    @IBAction func actionProfileBtn(_ sender: Any) {
        profileView.isHidden = false
        feedbackView.isHidden = true
        feedback_Btn.backgroundColor = UIColor.white
        profile_Btn.backgroundColor =  UIColor(red: 188/254, green: 227/254, blue: 182/254, alpha: 1.0)
    }
    
    @IBAction func actionFeedbackBtn(_ sender: Any) {
        userProfileApi()
        profileView.isHidden = true
        feedbackView.isHidden = false
        profile_Btn.backgroundColor = UIColor.white
        feedback_Btn.backgroundColor =  UIColor(red: 188/254, green: 227/254, blue: 182/254, alpha: 1.0)
        
    }
    @IBAction func actionAddFeedBackBtn(_ sender: Any) {
        addFeedback_View.isHidden = false
        addFeedback_Btn.isHidden = true
        addFeedbackBtn_Constraints.constant = 0
    }
    
    @IBAction func actionCancelBtn(_ sender: Any) {
        addFeedback_View.isHidden = true
        addFeedback_Btn.isHidden = false
        addFeedbackBtn_Constraints.constant = 40
    }
    
    @IBAction func actionSubmitBtn(_ sender: Any) {
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
