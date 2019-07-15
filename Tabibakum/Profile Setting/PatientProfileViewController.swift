//
//  PatientProfileViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 08/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

struct patientQuestionInfo {
    struct questionDetails {
        var from : String?
        var to : String?
        var id : Int?
        var patient_id : Int?
        var doctor_id  : Int?
        var audio : String?
        var image : String?
        var text : String?
        var filled : Int?
        var created_at : String?
        var type : String?
        var question : String?
    }
    var questionInfo : [patientQuestionInfo]
}

struct dcotorReportInfo {
    struct ReportDetails {
        var id : Int?
        var patient_id : Int?
        var doctor_id  : Int?
        var lab_report : String?
        var prescription : String?
        var doc_description : String?
        var name : String?
        var avatar : String?
        var specialist : String?
        var created_at : String?
    }
    var reportInfo : [dcotorReportInfo]
}

class PatientProfileViewController: UIViewController {
    @IBOutlet weak var profileImg_View: UIImageView!
    @IBOutlet weak var userName_Lbl: UILabel!
    @IBOutlet weak var description_txtView: UILabel!
    @IBOutlet weak var profileTblView: UITableView!
    @IBOutlet weak var complaintTblView: UITableView!
    @IBOutlet weak var doctorReviewTblView: UITableView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var weight_view: UIView!
    @IBOutlet weak var blooadGroup_View: UIView!
    @IBOutlet weak var growth_view: UIView!
    @IBOutlet weak var age_view: UIView!
    @IBOutlet weak var complaintView_HeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var patientInformation_HeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var doctorReview_HeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var weight_lbl: UILabel!
    @IBOutlet weak var bloodGroup_lbl: UILabel!
    @IBOutlet weak var growth_lbl: UILabel!
    @IBOutlet weak var age_lbl: UILabel!
    var doctorId = Int()
    var patientQuestionArr = [patientQuestionInfo.questionDetails]()
    var complaintQuestionArr = [patientQuestionInfo.questionDetails]()
    var doctorReportArr = [dcotorReportInfo.ReportDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        infoView.layer.cornerRadius = 10
        infoView.clipsToBounds = true
        infoView.layer.borderWidth = 0.5
        infoView.layer.borderColor = UIColor.lightGray.cgColor
        submitBtn.layer.cornerRadius = submitBtn.frame.height/2
        submitBtn.clipsToBounds = true
        profileImg_View.layer.cornerRadius = profileImg_View.frame.height/2
        profileImg_View.clipsToBounds = true
        weight_view.layer.cornerRadius = 10
        weight_view.clipsToBounds = true
        blooadGroup_View.layer.cornerRadius = 10
        blooadGroup_View.clipsToBounds = true
        growth_view.layer.cornerRadius = 10
        growth_view.clipsToBounds = true
        age_view.layer.cornerRadius = 10
        age_view.clipsToBounds = true
        
        profileTblView.register(UINib(nibName: "PatientQuestionTextTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientQuestionTextTableViewCell")
        
        profileTblView.register(UINib(nibName: "UploadTextAndImageTableViewCell", bundle: nil), forCellReuseIdentifier: "UploadTextAndImageTableViewCell")
        
        profileTblView.register(UINib(nibName: "PatientTextAudioImageTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientTextAudioImageTableViewCell")
        
        complaintTblView.register(UINib(nibName: "UploadTextAndImageTableViewCell", bundle: nil), forCellReuseIdentifier: "UploadTextAndImageTableViewCell")
        
        complaintTblView.register(UINib(nibName: "PatientQuestionTextTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientQuestionTextTableViewCell")
        
        complaintTblView.register(UINib(nibName: "PatientTextAudioImageTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientTextAudioImageTableViewCell")
        
        doctorReviewTblView.register(UINib(nibName: "DoctorReportTableViewCell", bundle: nil), forCellReuseIdentifier: "DoctorReportTableViewCell")
        
        doctorReviewTblView.register(UINib(nibName: "EnterDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "EnterDescriptionTableViewCell")
        // complaintView_HeightConstraints.constant = 3 * 61 + 40
        // patientInformation_HeightConstraints.constant = 3 * 170 + 40
        // doctorReview_HeightConstraints.constant = 4 * 114 + 131
        patientProfileApi()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func patientProfileApi(){
        var api = String()
        //api = Configurator.baseURL + ApiEndPoints.userdata + "?user_id=\(doctorId)" + "appoint_id=\("230")"
        api = "http://18.224.27.255:8000/api/userdata?user_id=311&appoint_id=203"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for userData in dataDict! {
                    self.userName_Lbl.text = userData["name"] as? String
                    let img =  userData["avatar"] as? String
                    let imageStr = Configurator.imageBaseUrl + img!
                    self.profileImg_View.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
                    self.description_txtView.text = userData["description"] as? String
                    self.weight_lbl.text = userData["weight"] as? String
                    self.bloodGroup_lbl.text = userData["bloodtype"] as? String
                    self.growth_lbl.text = userData["height"] as? String
                    self.age_lbl.text = userData["age"] as? String
                    
                    if let complaintanswerDict = userData["complaintanswer"] as? [[String:AnyObject]] {
                        for patientData in complaintanswerDict{
                            let questionNaire = patientQuestionInfo.questionDetails(
                                from: patientData["from"] as? String,
                                to: patientData["to"] as? String,
                                id: patientData["id"] as? Int,
                                patient_id: patientData["patient_id"] as? Int,
                                doctor_id: patientData["doctor_id"] as? Int,
                                audio: patientData["audio"] as? String,
                                image: patientData["image"] as? String,
                                text: patientData["text"] as? String,
                                filled: patientData["filled"] as? Int,
                                created_at: patientData["created_at"] as? String,
                                type: patientData["type"] as? String,
                                question: patientData["question"] as? String)
                            self.complaintQuestionArr.append(questionNaire)
                        }
                        self.complaintTblView.reloadData()
                    }
                    
                    if let patientanserDict = userData["patientansers"] as? [[String:AnyObject]] {
                        for patientData in patientanserDict{
                            let questionNaire = patientQuestionInfo.questionDetails(
                                from: patientData["from"] as? String,
                                to: patientData["to"] as? String,
                                id: patientData["id"] as? Int,
                                patient_id: patientData["patient_id"] as? Int,
                                doctor_id: patientData["doctor_id"] as? Int,
                                audio: patientData["audio"] as? String,
                                image: patientData["image"] as? String,
                                text: patientData["text"] as? String,
                                filled: patientData["filled"] as? Int,
                                created_at: patientData["created_at"] as? String,
                                type: patientData["type"] as? String,
                                question: patientData["question"] as? String)
                            print(questionNaire)
                            self.patientQuestionArr.append(questionNaire)
                            print(self.patientQuestionArr)
                        }
                        self.profileTblView.reloadData()
                    }
                    
                    if let reportDict = userData["report"] as? [[String:AnyObject]] {
                        for patientData in reportDict{
                            let questionNaire = dcotorReportInfo.ReportDetails(
                                id: patientData["id"] as? Int,
                                patient_id: patientData["patient_id"] as? Int,
                                doctor_id: patientData["doctor_id"] as? Int,
                                lab_report: patientData["lab_report"] as? String,
                                prescription: patientData["prescription"] as? String,
                                doc_description: patientData["doc_description"] as? String,
                                name: patientData["name"] as? String,
                                avatar: patientData["avatar"] as? String,
                                specialist: patientData["specialist"] as? String,
                                created_at: patientData["created_at"] as? String)
                            self.doctorReportArr.append(questionNaire)
                        }
                        self.doctorReviewTblView.reloadData()
                    }
                }
        }
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PatientProfileViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == complaintTblView {
            return complaintQuestionArr.count
        }else if tableView == profileTblView {
            return patientQuestionArr.count
        }else{
            return doctorReportArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == complaintTblView {
            if indexPath.row == 0 {
                return UITableView.automaticDimension
            }else if indexPath.row == 1 {
                return UITableView.automaticDimension
            }else{
                return UITableView.automaticDimension
            }
        }else if tableView == profileTblView {
            if indexPath.row == 0 {
                return UITableView.automaticDimension
            }else if indexPath.row == 1 {
                return UITableView.automaticDimension
                
            }else{
                return UITableView.automaticDimension
                
            }
        }else{
            if indexPath.row == 0 {
                return UITableView.automaticDimension
            }else if indexPath.row == 1 {
                return UITableView.automaticDimension
            }else if indexPath.row == 2 {
                return UITableView.automaticDimension
            }else{
                return UITableView.automaticDimension
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == complaintTblView {
            if complaintQuestionArr[indexPath.row].type == "list" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = complaintQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = complaintQuestionArr[indexPath.row].text
                return cell
            }else if complaintQuestionArr[indexPath.row].type == "text" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = complaintQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = complaintQuestionArr[indexPath.row].text
                return cell
            }else if complaintQuestionArr[indexPath.row].type == "yesno"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = complaintQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = complaintQuestionArr[indexPath.row].text
                return cell
            }else if complaintQuestionArr[indexPath.row].type == "tab1"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = complaintQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = complaintQuestionArr[indexPath.row].text
                return cell
            }else if complaintQuestionArr[indexPath.row].type == "tab2"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = complaintQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = complaintQuestionArr[indexPath.row].text
                return cell
            }else if complaintQuestionArr[indexPath.row].type == "image" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UploadTextAndImageTableViewCell") as! UploadTextAndImageTableViewCell
                cell.patientQuestionLbl.text = complaintQuestionArr[indexPath.row].question
                cell.patientAnswerLbl.text = complaintQuestionArr[indexPath.row].text
                cell.fillCollectionView(with: complaintQuestionArr[indexPath.row].image!)
                return cell
            }else if complaintQuestionArr[indexPath.row].type == "tai" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UploadTextAndImageTableViewCell") as! UploadTextAndImageTableViewCell
                cell.patientQuestionLbl.text = complaintQuestionArr[indexPath.row].question
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTextAudioImageTableViewCell") as! PatientTextAudioImageTableViewCell
                cell.patientQuestionLbl.text = patientQuestionArr[indexPath.row].question
                return cell
            }
        }else if tableView == profileTblView {
            if patientQuestionArr[indexPath.row].type == "list" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = patientQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = patientQuestionArr[indexPath.row].text
                return cell
            }else if patientQuestionArr[indexPath.row].type == "text" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = patientQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = patientQuestionArr[indexPath.row].text
                return cell
            }else if patientQuestionArr[indexPath.row].type == "yesno"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = patientQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = patientQuestionArr[indexPath.row].text
                return cell
            }else if patientQuestionArr[indexPath.row].type == "tab1"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = patientQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = patientQuestionArr[indexPath.row].text
                return cell
            }else if patientQuestionArr[indexPath.row].type == "tab2"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientQuestionTextTableViewCell") as! PatientQuestionTextTableViewCell
                cell.complaintQuestionLbl.text = patientQuestionArr[indexPath.row].question
                cell.complaintAnswerLbl.text = patientQuestionArr[indexPath.row].text
                return cell
            }else if patientQuestionArr[indexPath.row].type == "image" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UploadTextAndImageTableViewCell") as! UploadTextAndImageTableViewCell
                cell.patientQuestionLbl.text = patientQuestionArr[indexPath.row].question
                cell.patientAnswerLbl.text = patientQuestionArr[indexPath.row].text
                cell.fillCollectionView(with: patientQuestionArr[indexPath.row].image!)
//                cell.imageCollectionView.reloadData()
                return cell
            }else if patientQuestionArr[indexPath.row].type == "tai" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UploadTextAndImageTableViewCell") as! UploadTextAndImageTableViewCell
                cell.patientQuestionLbl.text = patientQuestionArr[indexPath.row].question
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTextAudioImageTableViewCell") as! PatientTextAudioImageTableViewCell
                cell.patientQuestionLbl.text = patientQuestionArr[indexPath.row].question
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorReportTableViewCell") as! DoctorReportTableViewCell
            if let img =  doctorReportArr[indexPath.row].avatar{
                let imageStr = Configurator.imageBaseUrl + img
            cell.profile_imgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
            }
            cell.userName_Lbl.text = doctorReportArr[indexPath.row].name
            cell.description_Lbl.text = doctorReportArr[indexPath.row].doc_description
            cell.date_Lbl.text = doctorReportArr[indexPath.row].created_at!.prefix(11).description
            return cell
        }
    }
}

extension PatientProfileViewController : UITableViewDelegate{
    
}

