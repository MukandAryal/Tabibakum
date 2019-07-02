//
//  QuestionNaireImageViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 11/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire
import Photos

class QuestionNaireImageViewController: BaseClassViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var questionNaire_Lbl: UILabel!
    @IBOutlet weak var uploadImg_ViewFirst: UIView!
    @IBOutlet weak var uploading_ViewSecond: UIView!
    @IBOutlet weak var uploading_viewThird: UIView!
    @IBOutlet weak var uploading_viewFourth: UIView!
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var uploading_viewSecondHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var uploding_viewThirdHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var upload_viewFourthHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var secondCamara_heightConstrants: NSLayoutConstraint!
    @IBOutlet weak var thirdCamera_heightConstraints: NSLayoutConstraint!
    @IBOutlet weak var fourthCamera_heightConstraints: NSLayoutConstraint!
    @IBOutlet weak var secondupload_txtHeightCons: NSLayoutConstraint!
    @IBOutlet weak var thiedupload_txtThirdHeightCons: NSLayoutConstraint!
    @IBOutlet weak var upload_txtFourrthHeightCons: NSLayoutConstraint!
    @IBOutlet weak var upload_photoFirstLbl: UILabel!
    @IBOutlet weak var upload_photoThirddLbl: UILabel!
    @IBOutlet weak var upload_photoFourthLbl: UILabel!
    @IBOutlet weak var upload_photoSecondLbl: UILabel!
    @IBOutlet weak var addmore_Btn: UIButton!
    @IBOutlet weak var firstUpload_imgBtn: UIButton!
    @IBOutlet weak var secondUpload_ImgBtn: UIButton!
    @IBOutlet weak var thirdUpload_ImgBtn: UIButton!
    @IBOutlet weak var fourthUpload_ImgBtn: UIButton!
    @IBOutlet weak var addMoretop_Constraints: NSLayoutConstraint!
    @IBOutlet weak var skipBtn: UIBarButtonItem!
    @IBOutlet weak var second_viewTralingConstraints: NSLayoutConstraint!
    @IBOutlet weak var third_viewTralingConstraints: NSLayoutConstraint!
    @IBOutlet weak var fourth_viewTralingConstraints: NSLayoutConstraint!
    @IBOutlet weak var second_viewDeleteIcon: UIButton!
    @IBOutlet weak var first_crossBtn: UIButton!
    @IBOutlet weak var second_crossBtn: UIButton!
    @IBOutlet weak var third_crossBtn: UIButton!
    @IBOutlet weak var third_deleteBtn: UIButton!
    @IBOutlet weak var fourth_crossBtn: UIButton!
    @IBOutlet weak var fourth_deleteBtn: UIButton!
    @IBOutlet weak var skip_Btn: UIBarButtonItem!
    @IBOutlet weak var back_Btn: UIBarButtonItem!
    @IBOutlet weak var documentImg_view: UIView!
    @IBOutlet weak var document_View: UIView!
    @IBOutlet weak var document_ImgView: UIImageView!
    var questionId = Int()
    var imgToUpload = [Data]()
    var skip = String()
    var arrSelectedImg = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImg_ViewFirst.layer.cornerRadius = 5
        uploadImg_ViewFirst.clipsToBounds = true
        uploadImg_ViewFirst.layer.borderWidth = 0.5
        uploadImg_ViewFirst.layer.borderColor = UIColor.lightGray.cgColor
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
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        uploading_viewSecondHeightConstraints.constant = 0
        uploding_viewThirdHeightConstraints.constant = 0
        upload_viewFourthHeightConstraints.constant = 0
        second_viewDeleteIcon.isHidden = true
        second_crossBtn.isHidden = true
        first_crossBtn.isHidden = true
        second_crossBtn.isHidden = true
        second_viewDeleteIcon.isHidden = true
        third_crossBtn.isHidden = true
        third_deleteBtn.isHidden = true
        fourth_crossBtn.isHidden = true
        fourth_deleteBtn.isHidden = true
        submit_Btn.backgroundColor = UiInterFace.appThemeColor
        self.navigationItem.rightBarButtonItem?.title = ""
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        documentImg_view.layer.cornerRadius = 10
        documentImg_view.clipsToBounds = true
        documentImg_view.isHidden = true
        questionNaireApi()
        
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
                    if type == "image"{
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
    
    
    func questionNaireAnswer(question_id:String,type:String,token:String,profileImg:[Data]){
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
                                    }else if indexingValue.questionNaireType == "updateQuestionNaire"{
                                        if self.skip != "0" {
                                            self.skipBtn.isEnabled = false
                                        }
                                        self.back_Btn.isEnabled = false
                                        self.backGroundColorBlur()
                                        self.questionNaireProcessUpdateSucessfully()
                                        
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
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            imgToUpload = [imageData]
        }
        
        if firstUpload_imgBtn.tag == 222{
            upload_photoFirstLbl.text = "Document 1.jpg"
            first_crossBtn.isHidden = false
            arrSelectedImg.updateValue(selectedImage, forKey: "imageFirst")
        }else if secondUpload_ImgBtn.tag == 333{
            upload_photoSecondLbl.text = "Document 2.jpg"
            second_viewDeleteIcon.isHidden = false
            second_crossBtn.isHidden = false
            second_viewTralingConstraints.constant = 50
            arrSelectedImg.updateValue(selectedImage, forKey: "imageSecond")
        }else if thirdUpload_ImgBtn.tag == 444{
            upload_photoThirddLbl.text = "Document 3.jpg"
            third_deleteBtn.isHidden = false
            third_crossBtn.isHidden = false
            third_viewTralingConstraints.constant = 50
            arrSelectedImg.updateValue(selectedImage, forKey: "imageThird")
        }else if fourthUpload_ImgBtn.tag == 555{
            upload_photoFourthLbl.text = "Document 4.jpg"
            fourth_deleteBtn.isHidden = false
            fourth_crossBtn.isHidden = false
            fourth_viewTralingConstraints.constant = 50
            arrSelectedImg.updateValue(selectedImage, forKey: "imageFourth")
        }
        dismiss(animated: true, completion: nil)
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
        if firstUpload_imgBtn.tag == 222{
            uploading_viewSecondHeightConstraints.constant = 40
            second_viewDeleteIcon.isHidden = true
            second_crossBtn.isHidden = true
            firstUpload_imgBtn.tag = 0
        }else if secondUpload_ImgBtn.tag == 333 {
            uploding_viewThirdHeightConstraints.constant = 40
        }else if thirdUpload_ImgBtn.tag == 444 {
            upload_viewFourthHeightConstraints.constant = 40
            addmore_Btn.isHidden = true
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please select above image!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionFirstImgUploadBtn(_ sender: Any) {
        if arrSelectedImg["imageFirst"] != nil {
            documentImg_view.isHidden = false
            addmore_Btn.isHidden = true
            document_ImgView.image = arrSelectedImg["imageFirst"] as? UIImage
            documentImg_view.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadImg_ViewFirst.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_ViewSecond.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewThird.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFourth.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            submit_Btn.isEnabled = false
            back_Btn.isEnabled = false
            first_crossBtn.isEnabled = false
            second_crossBtn.isEnabled = false
            third_crossBtn.isEnabled = false
            fourth_crossBtn.isEnabled = false
            second_viewDeleteIcon.isEnabled = false
            third_deleteBtn.isEnabled = false
            fourth_deleteBtn.isEnabled = false
        }else{
            firstUpload_imgBtn.tag = 222
            secondUpload_ImgBtn.tag = 0
            thirdUpload_ImgBtn.tag = 0
            fourthUpload_ImgBtn.tag = 0
            showAlert()
        }
    }
    
    @IBAction func actionSeconfImgUploadBtn(_ sender: Any) {
        if arrSelectedImg["imageSecond"] != nil {
            documentImg_view.backgroundColor = UIColor.white
            documentImg_view.isHidden = false
            addmore_Btn.isHidden = true
            document_ImgView.image = arrSelectedImg["imageSecond"] as? UIImage
            documentImg_view.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadImg_ViewFirst.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_ViewSecond.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewThird.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFourth.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            submit_Btn.isEnabled = false
            back_Btn.isEnabled = false
            first_crossBtn.isEnabled = false
            second_crossBtn.isEnabled = false
            third_crossBtn.isEnabled = false
            fourth_crossBtn.isEnabled = false
            second_viewDeleteIcon.isEnabled = false
            third_deleteBtn.isEnabled = false
            fourth_deleteBtn.isEnabled = false
        }else{
            secondUpload_ImgBtn.tag = 333
            firstUpload_imgBtn.tag = 0
            thirdUpload_ImgBtn.tag = 0
            fourthUpload_ImgBtn.tag = 0
            showAlert()
        }
    }
    
    @IBAction func upload_thirdImgBtn(_ sender: Any) {
        if arrSelectedImg["imageThird"] != nil {
            documentImg_view.backgroundColor = UIColor.white
            documentImg_view.isHidden = false
            addmore_Btn.isHidden = true
            document_ImgView.image = arrSelectedImg["imageThird"] as? UIImage
            documentImg_view.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadImg_ViewFirst.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_ViewSecond.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewThird.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFourth.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            submit_Btn.isEnabled = false
            back_Btn.isEnabled = false
            first_crossBtn.isEnabled = false
            second_crossBtn.isEnabled = false
            third_crossBtn.isEnabled = false
            fourth_crossBtn.isEnabled = false
            second_viewDeleteIcon.isEnabled = false
            third_deleteBtn.isEnabled = false
            fourth_deleteBtn.isEnabled = false
        }else{
            thirdUpload_ImgBtn.tag = 444
            firstUpload_imgBtn.tag = 0
            secondUpload_ImgBtn.tag = 0
            fourthUpload_ImgBtn.tag = 0
            showAlert()
        }
    }
    
    @IBAction func upload_fourthImgBtn(_ sender: Any) {
        if arrSelectedImg["imageFourth"] != nil {
            documentImg_view.backgroundColor = UIColor.white
            documentImg_view.isHidden = false
            addmore_Btn.isHidden = true
            document_ImgView.image = arrSelectedImg["imageFourth"] as? UIImage
            documentImg_view.backgroundColor = UIColor.white
            self.view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploadImg_ViewFirst.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_ViewSecond.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewThird.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            uploading_viewFourth.backgroundColor =  UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            submit_Btn.isEnabled = false
            back_Btn.isEnabled = false
            first_crossBtn.isEnabled = false
            second_crossBtn.isEnabled = false
            third_crossBtn.isEnabled = false
            fourth_crossBtn.isEnabled = false
            second_viewDeleteIcon.isEnabled = false
            third_deleteBtn.isEnabled = false
            fourth_deleteBtn.isEnabled = false
        }else{
            fourthUpload_ImgBtn.tag = 555
            firstUpload_imgBtn.tag = 0
            secondUpload_ImgBtn.tag = 0
            thirdUpload_ImgBtn.tag = 0
            showAlert()
        }
    }
    
    @IBAction func actionFirstCrossBtn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageFirst")
        upload_photoFirstLbl.text = "Upload photo"
        first_crossBtn.isHidden = true
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    @IBAction func actionSecondCrossBtn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageSecond")
        upload_photoSecondLbl.text = "Upload photo"
        second_crossBtn.isHidden = true
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    @IBAction func actionThirdCrossBtn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageThird")
        upload_photoThirddLbl.text = "Upload photo"
        third_crossBtn.isHidden = true
        addmore_Btn.isHidden = false
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
        
    }
    
    @IBAction func actionFourthCrossBtn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageFourth")
        upload_photoFourthLbl.text = "Upload photo"
        fourth_crossBtn.isHidden = true
        addmore_Btn.isHidden = false
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    
    @IBAction func secondViewDeleteBtn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageSecond")
        uploading_viewSecondHeightConstraints.constant = 0
        second_crossBtn.isHidden = true
        second_viewDeleteIcon.isHidden = true
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
        firstUpload_imgBtn.tag = 222
        upload_photoSecondLbl.text = "Upload photo"
        addmore_Btn.isHidden = false
    }
    
    @IBAction func actionThirdDeleteBtn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageThird")
        uploding_viewThirdHeightConstraints.constant = 0
        uploading_viewSecondHeightConstraints.constant = 40
        third_crossBtn.isHidden = true
        third_deleteBtn.isHidden = true
        addmore_Btn.isHidden = false
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
        upload_photoSecondLbl.text = "Upload photo"
        secondUpload_ImgBtn.tag = 333
        addmore_Btn.isHidden = false
    }
    
    @IBAction func actionfourthDeleteBtn(_ sender: Any) {
        arrSelectedImg.removeValue(forKey: "imageFourth")
        upload_viewFourthHeightConstraints.constant = 0
        fourth_crossBtn.isHidden = true
        fourth_deleteBtn.isHidden = true
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
        upload_photoFourthLbl.text = "Upload photo"
        thirdUpload_ImgBtn.tag = 444
        addmore_Btn.isHidden = false
    }
    
    @IBAction func actionDocumentCrossBtn(_ sender: Any) {
        documentImg_view.isHidden = true
        addmore_Btn.isHidden = false
        self.view.backgroundColor = UIColor.white
        uploadImg_ViewFirst.backgroundColor =  UIColor.white
        uploading_ViewSecond.backgroundColor =  UIColor.white
        uploading_viewThird.backgroundColor =  UIColor.white
        uploading_viewFourth.backgroundColor =  UIColor.white
        submit_Btn.isEnabled = true
        back_Btn.isEnabled = true
        first_crossBtn.isEnabled = true
        second_crossBtn.isEnabled = true
        third_crossBtn.isEnabled = true
        fourth_crossBtn.isEnabled = true
        second_viewDeleteIcon.isEnabled = true
        third_deleteBtn.isEnabled = true
        fourth_deleteBtn.isEnabled = true
    }
    
    @IBAction func actionSaveNextBtn(_ sender: Any) {
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        if  imgToUpload.count == 0 {
            let alert = UIAlertController(title: "Alert", message: "please select one document!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            questionNaireAnswer(question_id: questionId.description, type: "image", token: loginToken!, profileImg: imgToUpload)
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
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.backGroundColorBlur()
        self.questionNaireProcessExit()
        if self.skip != "0" {
            skip_Btn.isEnabled = false
        }
        back_Btn.isEnabled = false
    }
}
