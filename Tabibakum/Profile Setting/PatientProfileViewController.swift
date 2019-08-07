//
//  PatientProfileViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 08/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire
import AVKit

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

class PatientProfileViewController: BaseClassViewController, UITextViewDelegate {
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
    @IBOutlet weak var infoView_HeightContrainsts: NSLayoutConstraint!
    
    var doctorId = Int()
    var appointmentId = Int()
    var patientQuestionArr = [patientQuestionInfo.questionDetails]()
    var complaintQuestionArr = [patientQuestionInfo.questionDetails]()
    var doctorReportArr = [dcotorReportInfo.ReportDetails]()
    var reportDescriptionArr = dcotorReportInfo.ReportDetails()
    var patientId = Int()
    var descriptionStr = String()
    var prescriptionStr = String()
    var audioData = String()
    var player: AVAudioPlayer?
    var playerCurrentTime : float4?
   // var complaintArray = [String]()
    var complaintArray =  [patientQuestionInfo.questionDetails]()
    var complaintTaiArr = [String]()
    var patientArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewToLoad()
        patientProfileApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func viewToLoad(){
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
        weight_view.layer.borderWidth = 0.5
        weight_view.layer.borderColor = UIColor.lightText.cgColor
        blooadGroup_View.layer.borderWidth = 0.5
        blooadGroup_View.layer.borderColor = UIColor.lightText.cgColor
        growth_view.layer.borderWidth = 0.5
        growth_view.layer.borderColor = UIColor.lightText.cgColor
        age_view.layer.borderWidth = 0.5
        age_view.layer.borderColor = UIColor.lightText.cgColor
        description_txtView.text = ""
        age_lbl.text = ""
        bloodGroup_lbl.text = ""
        growth_lbl.text = ""
        weight_lbl.text = ""
        
        profileTblView.register(UINib(nibName: "PatientQuestionTextTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientQuestionTextTableViewCell")
        
        profileTblView.register(UINib(nibName: "UploadTextAndImageTableViewCell", bundle: nil), forCellReuseIdentifier: "UploadTextAndImageTableViewCell")
        
        profileTblView.register(UINib(nibName: "PatientTextAudioImageTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientTextAudioImageTableViewCell")
        
        complaintTblView.register(UINib(nibName: "complaintAudioImageTableViewCell", bundle: nil), forCellReuseIdentifier: "complaintAudioImageTableViewCell")
        
        complaintTblView.register(UINib(nibName: "complaintImageTableViewCell", bundle: nil), forCellReuseIdentifier: "complaintImageTableViewCell")
        
        complaintTblView.register(UINib(nibName: "PatientQuestionTextTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientQuestionTextTableViewCell")
        
        doctorReviewTblView.register(UINib(nibName: "DoctorReportTableViewCell", bundle: nil), forCellReuseIdentifier: "DoctorReportTableViewCell")
        
        doctorReviewTblView.register(UINib(nibName: "EnterDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "EnterDescriptionTableViewCell")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func patientProfileApi(){
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.userdata + "?user_id=\(doctorId)" + "&appoint_id=\(appointmentId)"
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
                    self.patientId = (userData["id"] as? Int)!
                    
                    
                    if let hei =  self.description_txtView.text?.height(withConstrainedWidth: self.view.frame.size.width-20, font: UIFont.systemFont(ofSize: 12.0)){
                        
                        self.infoView_HeightContrainsts.constant = hei + 140
                    }
                    
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
                      self.complaintTblView.layoutIfNeeded()
                        self.complaintView_HeightConstraints.constant = CGFloat(self.complaintTblView.contentSize.height + 40)
                        self.complaintTblView.isScrollEnabled = true
                     
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
                            
                            self.patientQuestionArr.append(questionNaire)
                            print(self.patientQuestionArr)
                        }
                        self.profileTblView.reloadData()
                        self.profileTblView.layoutIfNeeded()
                        self.patientInformation_HeightConstraints.constant = CGFloat(self.profileTblView.contentSize.height + 40)
                       
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
                        self.doctorReviewTblView.layoutIfNeeded()
                        self.doctorReview_HeightConstraints.constant = CGFloat(self.doctorReviewTblView.contentSize.height + 40)
                       
                    }
                }
        }
    }
    
    func priescriptionDescriptionApi(){
        self.showCustomProgress()
        let param: [String: Any] = [
            "patient_id" : patientId,
            "doctor_id" : doctorId,
            "lab_report" : prescriptionStr,
            "doc_description" : descriptionStr,
            "prescription" : descriptionStr
        ]
        print(param)
        var api = String()
        api = Configurator.baseURL + ApiEndPoints.post_lab_report
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.stopProgress()
                if let resultDict = response.value as? [String: AnyObject]{
                    if let sucessStr = resultDict["success"] as? Bool{
                        print(sucessStr)
                        if sucessStr{
                            print("sucessss")
                            self.descriptionStr = ""
                            self.prescriptionStr = ""
                            let indexPath = IndexPath(row: self.doctorReportArr.count, section: 0)
                            self.doctorReviewTblView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.bottom)
                            //                            self.doctorReviewTblView.reloadData()
                            self.showUpdateCustomDialog()
                            
                        }else {
                            let alert = UIAlertController(title: "Alert", message: "sumthing woring!", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
        }
    }
    
    func showUpdateCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireUpdateSucessView") as? QuestionNaireUpdateSucessView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.titleLable.text = "Sucessfully Submitted"
        exitVc!.okBtn.addTargetClosure { _ in
            popup.dismiss()
        }
        
        present(popup, animated: animated, completion: nil)
    }
    
    
    func showCustomAudioDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "PlayAudioViewController") as? PlayAudioViewController
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.palyAudio_lbl.text = "Play Audio"
        let image = UIImage(named: "music_play") as UIImage?
        exitVc?.play_Btn.setImage(image, for: .normal)
        exitVc!.play_Btn.addTargetClosure { _ in
            if exitVc?.play_Btn.currentImage == UIImage(named: "music_play") {
                let image = UIImage(named: "record_stop.png") as UIImage?
                exitVc?.play_Btn.setImage(image, for: .normal)
                self.playSound()
                exitVc?.audio_slider.minimumValue = 0.0
                exitVc?.audio_slider.maximumValue = Float(self.player?.duration ?? 0.0)
                exitVc?.audio_slider.setValue(Float(self.player?.currentTime ?? 0.0), animated: true)
            }else{
                let image = UIImage(named: "music_play") as UIImage?
                exitVc?.play_Btn.setImage(image, for: .normal)
                self.player?.stop()
            }
        }
        exitVc!.cross_btn.addTargetClosure { _ in
            self.player?.stop()
            popup.dismiss()
        }
        
        present(popup, animated: animated, completion: nil)
    }
    
    func showDoctorReviewCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorReviewDescriptionController") as? DoctorReviewDescriptionController
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        let imageStr = Configurator.imageBaseUrl
        if let img = reportDescriptionArr.avatar{
            let finalImg = imageStr + img
            exitVc?.userProfile_Img.sd_setImage(with: URL(string: finalImg), placeholderImage: UIImage(named: "user_pic"))
        }
        exitVc?.userName_Lbl.text = reportDescriptionArr.name
        exitVc?.specialityLbl.text = reportDescriptionArr.specialist
        exitVc?.DescriptionLbl.text = reportDescriptionArr.doc_description
        exitVc?.prescriptionLbl.text = reportDescriptionArr.prescription
        
        exitVc!.cross_btn.addTargetClosure { _ in
            popup.dismiss()
        }
        present(popup, animated: animated, completion: nil)
    }
    
    
    func playSound() {
        let baseUrl = Configurator.audioBaseUrl + audioData
        let urlstring = baseUrl
        let url = NSURL(string: urlstring)
        print("the url = \(url!)")
        downloadFileFromURL(url_: url!)
    }
    
    func downloadFileFromURL(url_:NSURL){
        var downloadTask:URLSessionDownloadTask
        let request = URLRequest(url:url_ as URL)
        downloadTask = URLSession.shared.downloadTask(with: request as URLRequest , completionHandler: { (url , response , error) in
            if error != nil {
                print("error in download file")
            } else {
                print(response as Any)
                self.play(url: url! as NSURL)
            }
        })
        downloadTask.resume()
    }
    
    func play(url:NSURL) {
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player!.prepareToPlay()
            player!.volume = 10.0
            player!.play()
            // playerCurrentTime = player?.currentTime.du
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
    
    @IBAction func actionSubmitBtn(_ sender: Any) {
        
        if descriptionStr == "" {
            let alert = UIAlertController(title: "Alert", message: "Please enter description!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if prescriptionStr == "" {
            let alert = UIAlertController(title: "Alert", message: "Please enter prescription!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            priescriptionDescriptionApi()
        }
    }
    
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.tag == 1{
            descriptionStr = textView.text
        }else{
            
            prescriptionStr = textView.text
        }
    }
}

extension PatientProfileViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == complaintTblView {
            return complaintQuestionArr.count
        }else if tableView == profileTblView {
            return patientQuestionArr.count
        }else{
            return doctorReportArr.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == complaintTblView {
            return UITableView.automaticDimension
        }else if tableView == profileTblView {
            return UITableView.automaticDimension
        }else{
            return UITableView.automaticDimension
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
            }
            else if complaintQuestionArr[indexPath.row].type == "image" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "complaintImageTableViewCell") as! complaintImageTableViewCell
                cell.questionLbl.text = complaintQuestionArr[indexPath.row].question
                cell.answerLbl.text = complaintQuestionArr[indexPath.row].text
                if let imgStr = complaintQuestionArr[indexPath.row].image {
                    cell.fillCollectionView(with: imgStr)
                }
                let arr_ = complaintQuestionArr[indexPath.row].image?.split(separator: ",").map { String($0) }
               // self.complaintArray = arr_ ?? [""]
                self.complaintArray = [complaintQuestionArr[indexPath.row]]
                print(self.complaintArray)
                cell.imageCollectionView.reloadData()
                cell.imageCollectionView.delegate = self
                cell.imageCollectionView.dataSource = self
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "complaintAudioImageTableViewCell") as! complaintAudioImageTableViewCell
                cell.questionLbl.text = complaintQuestionArr[indexPath.row].question
                cell.answerLbl.text = complaintQuestionArr[indexPath.row].text
                cell.fillCollectionView(with: complaintQuestionArr[indexPath.row].image ?? "", audioStr: complaintQuestionArr[indexPath.row].audio ?? "")
                let arr_ = complaintQuestionArr[indexPath.row].image?.split(separator: ",").map { String($0) }
                //self.complaintArray = arr_ ?? [""]
                self.complaintArray = [complaintQuestionArr[indexPath.row]]
                print(self.complaintArray)
                cell.complaintCollectionView.reloadData()
                cell.complaintCollectionView.delegate = self
                cell.complaintCollectionView.dataSource = self
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
            }
            else if patientQuestionArr[indexPath.row].type == "image" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UploadTextAndImageTableViewCell") as! UploadTextAndImageTableViewCell
                cell.patientQuestionLbl.text = patientQuestionArr[indexPath.row].question
                cell.patientAnswerLbl.text = patientQuestionArr[indexPath.row].text
                if let imgStr = patientQuestionArr[indexPath.row].image {
                    cell.fillCollectionView(with: imgStr)
                }
                let arr_ = patientQuestionArr[indexPath.row].image?.split(separator: ",").map { String($0) }
                self.patientArray = arr_ ?? [""]
                print(self.patientArray)
                cell.imageCollectionView.reloadData()
                cell.imageCollectionView.delegate = self
                cell.imageCollectionView.dataSource = self
                return cell
            }
            else  {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTextAudioImageTableViewCell") as! PatientTextAudioImageTableViewCell
                cell.patientQuestionLbl.text = patientQuestionArr[indexPath.row].question
                cell.text_lbl.text = patientQuestionArr[indexPath.row].text
                cell.fillCollectionView(with: patientQuestionArr[indexPath.row].image ?? "", audioStr: patientQuestionArr[indexPath.row].audio ?? "")
                let arr_ = patientQuestionArr[indexPath.row].image?.split(separator: ",").map { String($0) }
                self.patientArray = arr_ ?? [""]
                print(self.patientArray)
                cell.imageCollectionView.reloadData()
                cell.imageCollectionView.delegate = self
                cell.imageCollectionView.dataSource = self
              //  cell.imageCollectionView.tag = indexPath.row
     //           indexPathIndex = indexPath.row
                return cell
            }
        }else{
            if indexPath.row == doctorReportArr.count{
                let cell = tableView.dequeueReusableCell(withIdentifier: "EnterDescriptionTableViewCell") as! EnterDescriptionTableViewCell
                
                cell.description_txtView.text = descriptionStr
                cell.precription_txtView.text = prescriptionStr
                cell.description_txtView.delegate = self
                cell.precription_txtView.delegate = self
                cell.description_txtView.tag = 1
                cell.precription_txtView.tag = 2
                return cell
            }
            else{
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
}

extension PatientProfileViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == complaintTblView {
            if complaintQuestionArr[indexPath.row].type == "tai"{
                print(complaintQuestionArr[indexPath.row])
                if let audio = complaintQuestionArr[indexPath.row].audio{
                    audioData = audio
                    showCustomAudioDialog()
                }
            }
        }else if tableView == profileTblView{
            if patientQuestionArr[indexPath.row].type == "tai"{
                if let audio = patientQuestionArr[indexPath.row].audio{
                    audioData = audio
                    showCustomAudioDialog()
                }
            }
        }else{
            print(doctorReportArr[indexPath.row])
            reportDescriptionArr = doctorReportArr[indexPath.row]
            showDoctorReviewCustomDialog()
        }
    }
}

extension PatientProfileViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 109)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 11 {
            print("complaintArr>>>>>>>>>>>>>......")
            return complaintArray.count
        }else{
             print("patientArray>>>>>>>>>>>>>......")
            return patientArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 11 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                "UploadImageAndTextCollectionViewCell", for: indexPath) as! UploadImageAndTextCollectionViewCell
            if complaintArray[indexPath.row].type == "image"{
            let imageStr = Configurator.uploadsImgUrl
            let img = complaintArray[indexPath.item].image ?? ""
            let finalImg = imageStr + img
            cell.documentImgView.sd_setImage(with: URL(string: finalImg), placeholderImage: UIImage(named: "user_pic"))
                return cell
            }else{
                if complaintArray[indexPath.row].type == "tai"{
                    let imageStr = Configurator.uploadsImgUrl
                    let img = complaintArray[indexPath.item].image ?? ""
                    let finalImg = imageStr + img
                    cell.documentImgView.sd_setImage(with: URL(string: finalImg), placeholderImage: UIImage(named: "user_pic"))
                   return cell
            }
                return cell
        }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                "UploadImageAndTextCollectionViewCell", for: indexPath) as! UploadImageAndTextCollectionViewCell
            let imageStr = Configurator.uploadsImgUrl
            let img = patientArray[indexPath.item]
            let finalImg = imageStr + img
            cell.documentImgView.sd_setImage(with: URL(string: finalImg), placeholderImage: UIImage(named: "user_pic"))
            return cell
        }
    }
}

extension PatientProfileViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("complaintArray>>>>>>>>>>>.",complaintArray[indexPath.row])
        if collectionView.tag == 11 {
            if complaintArray[indexPath.row].type == "image"{
            print(complaintArray[indexPath.row])
            let imgstr = complaintArray[indexPath.row].image
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "ImageZoomViewController") as? ImageZoomViewController
            obj?.imageStr = imgstr ?? ""
            self.present(obj!, animated: true, completion: nil)
            }else if complaintArray[indexPath.row].type == "tai"{
                print(complaintArray[indexPath.row])
                let imgstr = complaintArray[indexPath.row].image
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "ImageZoomViewController") as? ImageZoomViewController
                obj?.imageStr = imgstr ?? ""
                self.present(obj!, animated: true, completion: nil)
            }
        }else {
            print(patientArray[indexPath.row])
            let imgstr = patientArray[indexPath.row]
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "ImageZoomViewController") as? ImageZoomViewController
            obj?.imageStr = imgstr
            self.present(obj!, animated: true, completion: nil)
       }
    }
}




