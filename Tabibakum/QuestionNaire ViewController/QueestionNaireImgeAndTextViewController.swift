//
//  QueestionNaireImgeAndTextViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 12/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire
import AVKit
//import Pulsator

class QueestionNaireImgeAndTextViewController: BaseClassViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioRecorderDelegate {
    
    @IBOutlet weak var uploadProblem_txtView: UITextView!
    @IBOutlet weak var questionNaire_Lbl: UILabel!
    @IBOutlet weak var uploadAudio_ViewFirst: UIView!
    @IBOutlet weak var uploading_ViewSecond: UIView!
    @IBOutlet weak var uploading_viewThird: UIView!
    @IBOutlet weak var uploading_viewFourth: UIView!
    @IBOutlet weak var uploading_viewFive: UIView!
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var uploading_viewSecondHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var uploding_viewThirdHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var upload_viewFourthHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var upload_viewFiveHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var secondCamara_heightConstrants: NSLayoutConstraint!
    @IBOutlet weak var thirdCamera_heightConstraints: NSLayoutConstraint!
    @IBOutlet weak var fourthCamera_heightConstraints: NSLayoutConstraint!
    @IBOutlet weak var fivethCamera_heightConstraints: NSLayoutConstraint!
    @IBOutlet weak var secondupload_txtHeightCons: NSLayoutConstraint!
    @IBOutlet weak var thiedupload_txtThirdHeightCons: NSLayoutConstraint!
    @IBOutlet weak var upload_txtFourrthHeightCons: NSLayoutConstraint!
    @IBOutlet weak var upload_txtFiveHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var upload_audio: UILabel!
    @IBOutlet weak var upload_photoThirddLbl: UILabel!
    @IBOutlet weak var upload_photoFourthLbl: UILabel!
    @IBOutlet weak var upload_photoSecondLbl: UILabel!
    @IBOutlet weak var addmore_Btn: UIButton!
    @IBOutlet weak var firstUpload_imgBtn: UIButton!
    @IBOutlet weak var secondUpload_ImgBtn: UIButton!
    @IBOutlet weak var thirdUpload_ImgBtn: UIButton!
    @IBOutlet weak var fourthUpload_ImgBtn: UIButton!
    @IBOutlet weak var fiveUploading_ImgBtn: UIButton!
    @IBOutlet weak var addMoretop_Constraints: NSLayoutConstraint!
    @IBOutlet weak var skipBtn: UIBarButtonItem!
    @IBOutlet weak var cross_btn: UIButton!
    @IBOutlet weak var delete_Btn: UIButton!
    @IBOutlet weak var secondView_tralingConstraints:
    NSLayoutConstraint!
    @IBOutlet weak var audionCross_Icon: UIButton!
    @IBOutlet weak var thirdView_tralingConstraints: NSLayoutConstraint!
    @IBOutlet weak var third_crossIconBtn: UIButton!
    @IBOutlet weak var third_DeleteBtn: UIButton!
    @IBOutlet weak var fourth_crossIconBtn: UIButton!
    @IBOutlet weak var fourth_DeleteBtn: UIButton!
    @IBOutlet weak var fourth_viewTralingConstraints: NSLayoutConstraint!
    @IBOutlet weak var five_deleteIcon: UIButton!
    @IBOutlet weak var five_crossIcon: UIButton!
    @IBOutlet weak var five_viewTralingConstraints: NSLayoutConstraint!
    @IBOutlet weak var upload_fivePhotoLbl: UILabel!
    @IBOutlet weak var skip_Btn: UIBarButtonItem!
    @IBOutlet weak var back_Btn: UIBarButtonItem!
    @IBOutlet weak var documentImg_view: UIView!
    @IBOutlet weak var document_View: UIView!
    @IBOutlet weak var document_ImgView: UIImageView!
    @IBOutlet weak var recording_View: UIView!
    @IBOutlet weak var recoedingTime_Lbl: UILabel!
    @IBOutlet weak var recording_slider: UISlider!
    @IBOutlet weak var recodringStart_Btn: UIButton!
    @IBOutlet weak var recordingSubmit_Btn: UIButton!
    @IBOutlet weak var recodring_reset_Btn: UIButton!
    @IBOutlet weak var recording_viewHeightConstraints: NSLayoutConstraint!
    
    var questionId = Int()
    var imgToUpload = [Data]()
    var arrImg = [UIImage]()
    var intCount = Int()
    var skip = String()
    var arrSelectedImg = [String:AnyObject]()
    // var recordingSession : AVAudioSession!
    // var audioRecorder    :AVAudioRecorder?
    var timer = Timer()
    var recordSeconds = 0
    var recordMinutes = 0
    var settings         = [String : Int]()
    // var recordButton: UIButton!
    var recordingSession: AVAudioSession?
    var audioRecorder: AVAudioRecorder?
    var bombSoundEffect: AVAudioPlayer?
    
    

    //let pulsator = Pulsator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("questionType>>>>>",indexingValue.questionType)
        uploadProblem_txtView.layer.cornerRadius = 5
        uploadProblem_txtView.clipsToBounds = true
        uploadProblem_txtView.layer.borderWidth = 0.5
        uploadProblem_txtView.layer.borderColor = UIColor.lightGray.cgColor
        uploadAudio_ViewFirst.layer.cornerRadius = 5
        uploadAudio_ViewFirst.clipsToBounds = true
        uploadAudio_ViewFirst.layer.borderWidth = 0.5
        uploadAudio_ViewFirst.layer.borderColor = UIColor.lightGray.cgColor
        uploading_ViewSecond.layer.cornerRadius = 5
        uploading_ViewSecond.clipsToBounds = true
        uploading_ViewSecond.layer.borderWidth = 0.5
        uploading_ViewSecond.layer.borderColor = UIColor.lightGray.cgColor
        uploading_viewThird.layer.cornerRadius = 5
        uploading_viewThird.clipsToBounds = true
        uploading_viewThird.layer.borderWidth = 0.5
        uploading_viewThird.layer.borderColor = UIColor.lightGray.cgColor
        uploading_viewFourth.layer.cornerRadius = 5
        uploading_viewFourth.clipsToBounds = true
        uploading_viewFourth.layer.borderWidth = 0.5
        uploading_viewFourth.layer.borderColor =  UIColor.lightGray.cgColor
        uploading_viewFive.layer.cornerRadius = 5
        uploading_viewFive.clipsToBounds = true
        uploading_viewFive.layer.borderWidth = 0.5
        uploading_viewFive.layer.borderColor = UIColor.lightGray.cgColor
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.backgroundColor = UiInterFace.appThemeColor
        submit_Btn.clipsToBounds = true
        five_crossIcon.isHidden = true
        five_deleteIcon.isHidden = true
        cross_btn.isHidden = true
        //  delete_Btn.isHidden = true
        audionCross_Icon.isHidden = true
        third_DeleteBtn.isHidden = true
        fourth_DeleteBtn.isHidden = true
        third_crossIconBtn.isHidden = true
        fourth_crossIconBtn.isHidden = true
        self.navigationItem.rightBarButtonItem?.title = ""
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        documentImg_view.layer.cornerRadius = 10
        documentImg_view.clipsToBounds = true
        documentImg_view.isHidden = true
        questionNaireApi()
        uploading_viewSecondHeightConstraints.constant = 40
        //secondCamara_heightConstrants.constant = 30
        //secondupload_txtHeightCons.constant = 15
        uploding_viewThirdHeightConstraints.constant = 0
        upload_viewFourthHeightConstraints.constant = 0
        // thirdCamera_heightConstraints.constant = 0
        //fourthCamera_heightConstraints.constant = 0
        //  thiedupload_txtThirdHeightCons.constant = 0
        //// upload_txtFourrthHeightCons.constant = 0
        //upload_txtFiveHeightConstraints.constant = 0
        upload_viewFiveHeightConstraints.constant = 0
        //fivethCamera_heightConstraints.constant = 0
        intCount = 0
        recording_View.isHidden = true
        let img = UIImage(named: "record_audio.png")
        recodringStart_Btn.setImage(img, for: .normal)
        recodringStart_Btn.addTarget(self, action:#selector(self.actionRecodringStart), for: .touchUpInside)
        
        // Audio Recording
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession?.setCategory(.playAndRecord, mode: .default)
            try recordingSession?.setActive(true)
            recordingSession?.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("recording Starting>>>")
                        // self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.exitBtn(_:)), name: NSNotification.Name(rawValue: "notificationlExit"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.contineBtn(_:)), name: NSNotification.Name(rawValue: "notificationContineBtn"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.doneBtn(_:)), name: NSNotification.Name(rawValue: "notificationlokBtn"), object: nil)
    }
    
    func questionNaireApi(){
        LoadingIndicatorView.show()
        let loginType = UserDefaults.standard.string(forKey: "loginType")
        var api = String()
        if loginType == "1" {
            api = Configurator.baseURL + ApiEndPoints.doctorquestion
        }else{
            if indexingValue.questionNaireType == "complaintQuestionNaire"{
                api = Configurator.baseURL + ApiEndPoints.complaintquestions
            }else{
                api = Configurator.baseURL + ApiEndPoints.patientquestion
            }
        }
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                 LoadingIndicatorView.hide()
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let type = specialistObj["type"] as? String
                    if type == "tai"{
                        self.questionId = specialistObj["id"] as! Int
                        self.questionNaire_Lbl.text = specialistObj["question"] as? String
                        self.skip = (specialistObj["skip"] as? String)!
                        if self.skip != "0" {
                            self.navigationItem.rightBarButtonItem?.title = "Skip"
                            self.navigationItem.rightBarButtonItem?.isEnabled = true
                        }
                    }
                }
        }
    }
    
    func questionNaireAnswer(question_id:String,type:String,token:String,text:String,profileImg:[Data]){
        LoadingIndicatorView.show()
        var api = String()
        let loginType = UserDefaults.standard.string(forKey: "loginType")
        if loginType == "1" {
            api = Configurator.baseURL + ApiEndPoints.doctoranswer
        }else{
            if indexingValue.questionNaireType == "complaintQuestionNaire"{
                api = Configurator.baseURL + ApiEndPoints.complaintanswer
            }else{
                api = Configurator.baseURL + ApiEndPoints.patientanswer
            }
        }
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(question_id.data(using: String.Encoding.utf8)!, withName: "question_id")
                multipartFormData.append(type.data(using: String.Encoding.utf8)!, withName: "type")
                multipartFormData.append(token.data(using: String.Encoding.utf8)!, withName: "token")
                multipartFormData.append(text.data(using: String.Encoding.utf8)!, withName: "text")
                for img in profileImg {
                    multipartFormData.append(img, withName: "image", fileName: "\(String(NSDate().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")).jpeg", mimeType: "image/jpeg")
                }
                print(multipartFormData)
        },
            to:api,
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response)
                        LoadingIndicatorView.hide()
                        var resultDict = response.value as? [String:Any]
                        if let sucessStr = resultDict!["success"] as? Bool{
                            print(sucessStr)
                            if sucessStr{
                                print("sucessss")
                                if indexingValue.questionType.count == indexingValue.indexValue {
                                    if indexingValue.questionNaireType == "singUpQuestionNaire" {
                                        let Obj = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsViewController")as! TermsAndConditionsViewController
                                        self.navigationController?.pushViewController(Obj, animated:true)
                                        print("last index")
                                    }
                                    else if indexingValue.questionNaireType == "complaintQuestionNaire" {
                                        let Obj = self.storyboard?.instantiateViewController(withIdentifier: "AvailableDoctorsViewController")as! AvailableDoctorsViewController
                                        self.navigationController?.pushViewController(Obj, animated:true)
                                        print("last index")
                                    }else {
                                        let Obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
                                        self.navigationController?.pushViewController(Obj, animated:true)
                                        print("last index")
                                    }
                                }
                                else if indexingValue.questionType[indexingValue.indexValue] == "text"{
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
                                indexingValue.indexValue = indexingValue.indexValue + 1
                                
                            }else{
                                let msg = resultDict!["message"] as? String
                                let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        }
                        .uploadProgress { progress in // main queue by default
                            print("Upload Progress: \(progress.fractionCompleted)")
                    }
                    return
                case .failure(let encodingError):
                    debugPrint(encodingError)
                }
        })
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        arrImg.append(selectedImage)
        print("arrimg>>>>>>.",arrImg)
        
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            imgToUpload.append(imageData)
            print("imgToUpload>>>",imgToUpload)
        }
        
        //   upload_photoFirstLbl.text = "PatientAudio.mp3"
        //  audionCross_Icon.isHidden = false
        
        if intCount == arrImg.count - 1{
            if intCount==0{
                upload_photoSecondLbl.text = "Document 1.jpg"
                cross_btn.isHidden = false
                arrSelectedImg.updateValue(selectedImage, forKey: "imageFirst")
            }else if intCount == 1{
                upload_photoThirddLbl.text = "Document 2.jpg"
                third_crossIconBtn.isHidden = false
                third_DeleteBtn.isHidden = false
                thirdView_tralingConstraints.constant = 60
                arrSelectedImg.updateValue(selectedImage, forKey: "imageSecond")
            }else if intCount == 2 {
                upload_photoFourthLbl.text = "Document 3.jpg"
                fourth_crossIconBtn.isHidden = false
                fourth_DeleteBtn.isHidden = false
                fourth_viewTralingConstraints.constant = 60
                arrSelectedImg.updateValue(selectedImage, forKey: "imageThird")
            }
        }else{
            upload_fivePhotoLbl.text = "Document 4.jpg"
            five_crossIcon.isHidden = false
            five_deleteIcon.isHidden = false
            five_viewTralingConstraints.constant = 60
            arrSelectedImg.updateValue(selectedImage, forKey: "imageFourth")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
       let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("paths>>",paths)
        return paths[0]
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            countdown()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown) , userInfo: nil, repeats: true)
            audioRecorder?.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder?.stop()
        audioRecorder = nil
        if success {
            // recordButton.setTitle("Tap to Re-record", for: .normal)
            print("re_record>>>>>>")
        } else {
            //  recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
            print("failed>>>>>>")
        }
    }
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    @objc func countdown() {
        
        var seconds = "\(recordSeconds)"
        if recordSeconds < 10 {
            seconds = "0\(recordSeconds)"
        }
        var minutes = "\(recordMinutes)"
        if recordMinutes < 10 {
            minutes = "0\(recordMinutes)"
        }
        recoedingTime_Lbl.text = "\(minutes):\(seconds)"
        
        recordSeconds += 1
        
        if recordSeconds == 60 {
            recordMinutes += 1
            recordSeconds = 0
        }
    }
    
    //MARK:- AVAudioRecorder Delegates
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    @objc func doneBtn(_ notification: NSNotification) {
        print("exitBtn>>")
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // handle notification
    @objc func exitBtn(_ notification: NSNotification) {
        print("exitBtn>>")
        if indexingValue.questionNaireType == "singUpQuestionNaire"{
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(obj, animated: true)
        }else{
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(obj, animated: true)
        }
    }
    
    @objc func contineBtn(_ notification: NSNotification) {
        print("logout>>")
        if self.skip != "0" {
            skip_Btn.isEnabled = true
        }
        back_Btn.isEnabled = true
        self.myCustomView?.isHidden = true
        self.backGroundBlurRemove()
    }
    
    @IBAction func actionAddMoreBtn(_ sender: Any) {
        if intCount == arrImg.count - 1{
            if intCount==0{
                uploding_viewThirdHeightConstraints.constant = 40
                intCount = intCount + 1
            }
            else if intCount == 1{
                upload_viewFourthHeightConstraints.constant = 40
                intCount = intCount + 1
            }else if intCount == 2 {
                upload_viewFiveHeightConstraints.constant = 40
                addmore_Btn.isHidden = true
            }
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please select above image!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionDocumentCrossBtn(_ sender: Any) {
        documentImg_view.isHidden = true
        addmore_Btn.isHidden = false
        self.view.backgroundColor = UIColor.white
        uploadAudio_ViewFirst.backgroundColor =  UIColor.white
        uploading_ViewSecond.backgroundColor =  UIColor.white
        uploading_viewThird.backgroundColor =  UIColor.white
        uploading_viewFourth.backgroundColor =  UIColor.white
        uploadProblem_txtView.backgroundColor =  UIColor.white
        submit_Btn.isEnabled = true
        back_Btn.isEnabled = true
        audionCross_Icon.isEnabled = true
        cross_btn.isEnabled = true
        third_crossIconBtn.isEnabled = true
        fourth_crossIconBtn.isEnabled = true
        five_crossIcon.isEnabled = true
        third_DeleteBtn.isEnabled = true
        fourth_DeleteBtn.isEnabled = true
        five_deleteIcon.isEnabled = true
    }
    
    @IBAction func actionAudioRecordingBtn(_ sender: Any) {
        recording_View.isHidden = false
        recording_View.layer.cornerRadius = 10
        recording_View.clipsToBounds = true
        recodringStart_Btn.isUserInteractionEnabled = true
        recordingSubmit_Btn.isHidden = true
        recodring_reset_Btn.isHidden = true
        recording_slider.isHidden = true
        recording_viewHeightConstraints.constant = 260
        recording_View.isHidden = false
        recording_slider.isHidden = true
        recordingSubmit_Btn.isHidden = true
        recodring_reset_Btn.isHidden = true
        recording_View.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        uploading_viewFive.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        uploading_ViewSecond.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        uploading_viewThird.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        uploading_viewFourth.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        uploadAudio_ViewFirst.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        uploadProblem_txtView.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        submit_Btn.isEnabled = false
        back_Btn.isEnabled = false
        audionCross_Icon.isEnabled = false
        cross_btn.isEnabled = false
        third_crossIconBtn.isEnabled = false
        fourth_crossIconBtn.isEnabled = false
        five_crossIcon.isEnabled = false
        third_DeleteBtn.isEnabled = false
        fourth_DeleteBtn.isEnabled = false
        five_deleteIcon.isEnabled = false
    }
    
    @objc func actionRecodringStart() {
        print("actionRecodringStart")
        recordTapped()
        let img = UIImage(named: "record_stop.png")
        recodringStart_Btn.setImage(img, for: .normal)
        recodringStart_Btn.addTarget(self, action:#selector(self.actionRecodringStop), for: .touchUpInside)
    }
    
    @objc func actionRecodringStop() {
        print("actionRecodringStop")
        recording_viewHeightConstraints.constant = 350
        recordingSubmit_Btn.isHidden = false
        recodring_reset_Btn.isHidden = false
        recording_slider.isHidden = false
        timer.invalidate()
        print(timer.tolerance)
        finishRecording(success: true)
        let img = UIImage(named: "music_play.png")
        recodringStart_Btn.setImage(img, for: .normal)
        recodringStart_Btn.addTarget(self, action:#selector(self.actionRecodringPlay), for: .touchUpInside)
    }
    
    @objc func actionRecodringPlay() {
        print("actionRecodringPlay")
        let path = Bundle.main.path(forResource: "example.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    @IBAction func actionRecodringCrossBtn(_ sender: Any) {
        timer.invalidate()
        let img = UIImage(named: "record_audio.png")
        recodringStart_Btn.setImage(img, for: .normal)
        recodringStart_Btn.addTarget(self, action:#selector(self.actionRecodringStart), for: .touchUpInside)
        recording_View.isHidden = true
        recording_slider.isHidden = true
        recordingSubmit_Btn.isHidden = true
        recodring_reset_Btn.isHidden = true
        recording_View.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        uploading_viewFive.backgroundColor =  UIColor.white
        uploading_ViewSecond.backgroundColor =  UIColor.white
        uploading_viewThird.backgroundColor =  UIColor.white
        uploading_viewFourth.backgroundColor =  UIColor.white
        uploadAudio_ViewFirst.backgroundColor =  UIColor.white
        uploadProblem_txtView.backgroundColor =  UIColor.white
        submit_Btn.isEnabled = true
        back_Btn.isEnabled = true
        audionCross_Icon.isEnabled = true
        cross_btn.isEnabled = true
        third_crossIconBtn.isEnabled = true
        fourth_crossIconBtn.isEnabled = true
        five_crossIcon.isEnabled = true
        third_DeleteBtn.isEnabled = true
        fourth_DeleteBtn.isEnabled = true
        five_deleteIcon.isEnabled = true
    }
    
    @IBAction func actionSeconfImgUploadBtn(_ sender: Any) {
        if arrSelectedImg["imageFirst"] != nil {
            documentImg_view.isHidden = false
            addmore_Btn.isHidden = true
            document_ImgView.image = arrSelectedImg["imageFirst"] as? UIImage
            documentImg_view.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFive.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_ViewSecond.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewThird.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFourth.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadAudio_ViewFirst.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadProblem_txtView.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            submit_Btn.isEnabled = false
            back_Btn.isEnabled = false
            audionCross_Icon.isEnabled = false
            cross_btn.isEnabled = false
            third_crossIconBtn.isEnabled = false
            fourth_crossIconBtn.isEnabled = false
            five_crossIcon.isEnabled = false
            third_DeleteBtn.isEnabled = false
            fourth_DeleteBtn.isEnabled = false
            five_deleteIcon.isEnabled = false
        }else{
            showAlert()
        }
    }
    
    @IBAction func upload_thirdImgBtn(_ sender: Any) {
        if arrSelectedImg["imageSecond"] != nil {
            documentImg_view.isHidden = false
            addmore_Btn.isHidden = true
            document_ImgView.image = arrSelectedImg["imageSecond"] as? UIImage
            documentImg_view.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFive.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_ViewSecond.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewThird.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFourth.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadAudio_ViewFirst.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadProblem_txtView.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            submit_Btn.isEnabled = false
            back_Btn.isEnabled = false
            audionCross_Icon.isEnabled = false
            cross_btn.isEnabled = false
            third_crossIconBtn.isEnabled = false
            fourth_crossIconBtn.isEnabled = false
            five_crossIcon.isEnabled = false
            third_DeleteBtn.isEnabled = false
            fourth_DeleteBtn.isEnabled = false
            five_deleteIcon.isEnabled = false
        }else{
            showAlert()
        }
    }
    
    @IBAction func upload_fourthImgBtn(_ sender: Any) {
        if arrSelectedImg["imageThird"] != nil {
            documentImg_view.isHidden = false
            addmore_Btn.isHidden = true
            document_ImgView.image = arrSelectedImg["imageThird"] as? UIImage
            documentImg_view.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFive.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_ViewSecond.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewThird.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFourth.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadAudio_ViewFirst.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadProblem_txtView.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            submit_Btn.isEnabled = false
            back_Btn.isEnabled = false
            audionCross_Icon.isEnabled = false
            cross_btn.isEnabled = false
            third_crossIconBtn.isEnabled = false
            fourth_crossIconBtn.isEnabled = false
            five_crossIcon.isEnabled = false
            third_DeleteBtn.isEnabled = false
            fourth_DeleteBtn.isEnabled = false
            five_deleteIcon.isEnabled = false
        }else{
            showAlert()
        }
    }
    @IBAction func upload_fiveImgBtn(_ sender: Any) {
        if arrSelectedImg["imageFourth"] != nil {
            documentImg_view.isHidden = false
            addmore_Btn.isHidden = true
            document_ImgView.image = arrSelectedImg["imageFourth"] as? UIImage
            documentImg_view.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFive.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_ViewSecond.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewThird.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFourth.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadAudio_ViewFirst.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadProblem_txtView.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            submit_Btn.isEnabled = false
            back_Btn.isEnabled = false
            audionCross_Icon.isEnabled = false
            cross_btn.isEnabled = false
            third_crossIconBtn.isEnabled = false
            fourth_crossIconBtn.isEnabled = false
            five_crossIcon.isEnabled = false
            third_DeleteBtn.isEnabled = false
            fourth_DeleteBtn.isEnabled = false
            five_deleteIcon.isEnabled = false
        }else{
            showAlert()
        }
    }
    
    @IBAction func actionSaveNextBtn(_ sender: Any) {
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        if  uploadProblem_txtView.text == "" {
            let alert = UIAlertController(title: "Alert", message: "please enter your problem!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            questionNaireAnswer(question_id: questionId.description, type: "tai", token: loginToken!, text: uploadProblem_txtView.text, profileImg: imgToUpload)
        }
    }
    
    
    @IBAction func actionSkipBtn(_ sender: Any) {
        if indexingValue.questionType.count == indexingValue.indexValue {
            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsViewController")as! TermsAndConditionsViewController
            self.navigationController?.pushViewController(Obj, animated:true)
            print("last index")
        }
        else if indexingValue.questionType[indexingValue.indexValue] == "text"{
            print("text")
            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireTextViewController")as! QuestionNaireTextViewController
            self.navigationController?.pushViewController(Obj, animated:true)
        }else if indexingValue.questionType[indexingValue.indexValue] == "yesno"{
            print("yes")
            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireTextViewController")as! QuestionNaireTextViewController
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
        indexingValue.indexValue = indexingValue.indexValue + 1
    }
    
    @IBAction func actionAudio_crossIcon(_ sender: Any) {
        upload_audio.text = "Upload audio"
        audionCross_Icon.isHidden = true
    }
    
    @IBAction func actionSubmitBtn(_ sender: Any) {
        recording_View.isHidden = true
        upload_audio.text = "audio1"
        let img = UIImage(named: "record_audio.png")
        recodringStart_Btn.setImage(img, for: .normal)
        recodringStart_Btn.addTarget(self, action:#selector(self.actionRecodringStart), for: .touchUpInside)
        recording_View.isHidden = true
        recording_slider.isHidden = true
        recordingSubmit_Btn.isHidden = true
        recodring_reset_Btn.isHidden = true
        recording_View.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        uploading_viewFive.backgroundColor =  UIColor.white
        uploading_ViewSecond.backgroundColor =  UIColor.white
        uploading_viewThird.backgroundColor =  UIColor.white
        uploading_viewFourth.backgroundColor =  UIColor.white
        uploadAudio_ViewFirst.backgroundColor =  UIColor.white
        uploadProblem_txtView.backgroundColor =  UIColor.white
        submit_Btn.isEnabled = true
        back_Btn.isEnabled = true
        audionCross_Icon.isEnabled = true
        cross_btn.isEnabled = true
        third_crossIconBtn.isEnabled = true
        fourth_crossIconBtn.isEnabled = true
        five_crossIcon.isEnabled = true
        third_DeleteBtn.isEnabled = true
        fourth_DeleteBtn.isEnabled = true
        five_deleteIcon.isEnabled = true
    }
    
    @IBAction func actionResetBtn(_ sender: Any) {
    }
    
    @IBAction func actionCrossBtn(_ sender: UIButton) {
        arrImg.remove(at: sender.tag)
        intCount = intCount - 1
        if sender.tag == 0{
            upload_photoSecondLbl.text = "Upload photo"
            cross_btn.isHidden = true
            arrSelectedImg.removeValue(forKey: "imageFirst")
        }else if sender.tag == 1 {
            upload_photoThirddLbl.text = "Upload photo"
            third_crossIconBtn.isHidden = true
            arrSelectedImg.removeValue(forKey: "imageSecond")
        }else if sender.tag == 2 {
            upload_photoFourthLbl.text = "Upload photo"
            fourth_crossIconBtn.isHidden = true
            arrSelectedImg.removeValue(forKey: "imageThird")
        }else {
            upload_fivePhotoLbl.text = "Upload photo"
            five_crossIcon.isHidden = true
            arrSelectedImg.removeValue(forKey: "imageFifth")
        }
    }
    
    @IBAction func actionThirdDelete_Btn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageSecond")
        uploding_viewThirdHeightConstraints.constant = 0
        third_DeleteBtn.isHidden = true
        addmore_Btn.isHidden = false
        arrImg.remove(at: 1)
        intCount = intCount - 1
    }
    
    @IBAction func actionFourth_deleteBtn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageThird")
        upload_viewFourthHeightConstraints.constant = 0
        fourth_DeleteBtn.isHidden = true
        addmore_Btn.isHidden = false
        arrImg.remove(at: 2)
        intCount = intCount - 1
    }
    
    @IBAction func actionFifth_deleteBtn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageFourth")
        upload_viewFiveHeightConstraints.constant = 0
        five_deleteIcon.isHidden = true
        addmore_Btn.isHidden = false
        arrImg.remove(at: 3)
        intCount = intCount - 1
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.backGroundColorBlur()
        self.questionNaireProcessExit()
        if self.skip != "0" {
            skip_Btn.isEnabled = false
        }
        back_Btn.isEnabled = false
    }
}
