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
    var btn_Index = 1252
    var deleteBox_Index = 125
    var questionId = Int()
    var imgToUpload = [UIImage]()
    var skip = String()
    var arrSelectedImg = [String:AnyObject]()
    var boxCount = Int()
    
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
        boxCount = 1
        questionNaireApi()
        
    }
    
    func questionNaireApi(){
        self.showCustomProgress()
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
                
              //  print(response)
                self.stopProgress()
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
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
    
    
    func questionNaireAnswer(question_id:String,type:String,token:String,profileImg:[UIImage]){
       self.showCustomProgress()
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
                    let imgData = img.jpegData(compressionQuality: 0.5)
                    multipartFormData.append(imgData!, withName: "image[]", fileName: "\(String(NSDate().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")).jpeg", mimeType: "image/jpeg")
                }
                print(multipartFormData)
        },
            to:api,
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        self.stopProgress()
                        var resultDict = response.value as? [String:Any]
                        if let sucessStr = resultDict?["success"] as? Bool{
                            if sucessStr{
                                indexingValue.indexCount = indexingValue.indexCount + 1
                                if indexingValue.questionType.count == indexingValue.indexValue {
                                    let loginType = UserDefaults.standard.string(forKey: "loginType")
                                    if loginType == "1" {
                                        if indexingValue.questionNaireType == "updateQuestionNaire" {
                                            if self.skip != "0" {
                                                self.skipBtn.isEnabled = false
                                            }
                                            self.back_Btn.isEnabled = false
                                            self.showUpdateCustomDialog()
                                        }else{
                                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsViewController")as! TermsAndConditionsViewController
                                            self.navigationController?.pushViewController(Obj, animated:true)
                                            print("last index")
                                        }
                                    }else {
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
                                              self.showUpdateCustomDialog()
                                            
                                        }else {
                                            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
                                            self.navigationController?.pushViewController(Obj, animated:true)
                                        }
                                    }
                                }else if indexingValue.questionType[indexingValue.indexValue] == "text"{
                                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireTextViewController")as! QuestionNaireTextViewController
                                    self.navigationController?.pushViewController(Obj, animated:true)
                                }else if indexingValue.questionType[indexingValue.indexValue] == "yesno"{
                                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionYesNoViewController")as! QuestionYesNoViewController
                                    self.navigationController?.pushViewController(Obj, animated:true)
                                }else if indexingValue.questionType[indexingValue.indexValue] == "list"{
                                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "ListQuestionNaireViewController")as! ListQuestionNaireViewController
                                    self.navigationController?.pushViewController(Obj, animated:true)
                                }else if indexingValue.questionType[indexingValue.indexValue] == "image"{
                                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireImageViewController")as! QuestionNaireImageViewController
                                    self.navigationController?.pushViewController(Obj, animated:true)
                                }else if indexingValue.questionType[indexingValue.indexValue] == "tab1"{
                                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireSingalTabViewController")as! QuestionNaireSingalTabViewController
                                    self.navigationController?.pushViewController(Obj, animated:true)
                                }else if indexingValue.questionType[indexingValue.indexValue] == "tab2"{
                                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireMultipleTabViewController")as! QuestionNaireMultipleTabViewController
                                    self.navigationController?.pushViewController(Obj, animated:true)
                                }else if indexingValue.questionType[indexingValue.indexValue] == "tai"{
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
                           // print("Upload Progress: \(progress.fractionCompleted)")
                    }
                    return
                case .failure(let encodingError):
                    debugPrint(encodingError)
                    self.stopProgress()
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
            imgToUpload.append(selectedImage)
        
        if btn_Index == 1 {
            upload_photoFirstLbl.text = "Document 1.jpg"
            first_crossBtn.isHidden = false
            arrSelectedImg.updateValue(selectedImage, forKey: "imageFirst")
        }else if btn_Index == 2{
            upload_photoSecondLbl.text = "Document 2.jpg"
            second_viewDeleteIcon.isHidden = false
            second_crossBtn.isHidden = false
            second_viewTralingConstraints.constant = 50
            arrSelectedImg.updateValue(selectedImage, forKey: "imageSecond")
        }else if btn_Index == 3{
            upload_photoThirddLbl.text = "Document 3.jpg"
            third_deleteBtn.isHidden = false
            third_crossBtn.isHidden = false
            third_viewTralingConstraints.constant = 50
            arrSelectedImg.updateValue(selectedImage, forKey: "imageThird")
        }else if btn_Index == 4{
            upload_photoFourthLbl.text = "Document 4.jpg"
            fourth_deleteBtn.isHidden = false
            fourth_crossBtn.isHidden = false
            fourth_viewTralingConstraints.constant = 50
            arrSelectedImg.updateValue(selectedImage, forKey: "imageFourth")
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionAddMoreBtn(_ sender: Any) {
        checkDocumentValidation()
    }
    
    @IBAction func actionFirstImgUploadBtn(_ sender: Any) {
        if arrSelectedImg["imageFirst"] != nil {
            showDocumentCustomDialog(image: (arrSelectedImg["imageFirst"] as? UIImage)!)
        }else{
            btn_Index = 1
            secondUpload_ImgBtn.tag = 0
            thirdUpload_ImgBtn.tag = 0
            fourthUpload_ImgBtn.tag = 0
            showAlert()
        }
    }
    
    @IBAction func actionSeconfImgUploadBtn(_ sender: Any) {
        if arrSelectedImg["imageSecond"] != nil {
            showDocumentCustomDialog(image: (arrSelectedImg["imageSecond"] as? UIImage)!)
        }else{
            btn_Index = 2
            firstUpload_imgBtn.tag = 0
            thirdUpload_ImgBtn.tag = 0
            fourthUpload_ImgBtn.tag = 0
            showAlert()
        }
    }
    
    @IBAction func upload_thirdImgBtn(_ sender: Any) {
        if arrSelectedImg["imageThird"] != nil {
            showDocumentCustomDialog(image: (arrSelectedImg["imageThird"] as? UIImage)!)
        }else{
            btn_Index = 3
            firstUpload_imgBtn.tag = 0
            secondUpload_ImgBtn.tag = 0
            fourthUpload_ImgBtn.tag = 0
            showAlert()
        }
    }
    
    @IBAction func upload_fourthImgBtn(_ sender: Any) {
        if arrSelectedImg["imageFourth"] != nil {
            showDocumentCustomDialog(image: (arrSelectedImg["imageFourth"] as? UIImage)!)
        }else{
            btn_Index = 4
            firstUpload_imgBtn.tag = 0
            secondUpload_ImgBtn.tag = 0
            thirdUpload_ImgBtn.tag = 0
            showAlert()
        }
    }
    
    @IBAction func actionFirstCrossBtn(_ sender: UIButton) {
        showDeleteCustomDialog(sender: sender.tag)
    }
    
    func removeSelectionDocument(_ sender: Int){
        if sender == 1{
            arrSelectedImg.removeValue(forKey: "imageFirst")
            boxCount = boxCount - 1
            first_crossBtn.isHidden = true
            upload_photoFirstLbl.text = "Upload photo"
        }
        else  if sender == 2{
            arrSelectedImg.removeValue(forKey: "imageSecond")
            boxCount = boxCount - 1
            second_crossBtn.isHidden = true
            upload_photoSecondLbl.text = "Upload photo"
            
        }
        else  if sender == 3{
            arrSelectedImg.removeValue(forKey: "imageThird")
            boxCount = boxCount - 1
            third_crossBtn.isHidden = true
            upload_photoThirddLbl.text = "Upload photo"
        }
        else{
            arrSelectedImg.removeValue(forKey: "imageFourth")
            boxCount = boxCount - 1
            fourth_crossBtn.isHidden = true
            upload_photoFourthLbl.text = "Upload photo"
        }
    }
    
    func checkDocumentValidation() {
        print("boxCount",boxCount)
        print("arrSelectedImg",arrSelectedImg.count)
        if boxCount == arrSelectedImg.count || (boxCount == 0 && arrSelectedImg.count == 0){
            if arrSelectedImg.count == 0 {
                boxCount = boxCount + 1
            }
            else if arrSelectedImg.count == 1 {
                if (arrSelectedImg.index(forKey: "imageFirst") != nil){
                    print("imageFirstimageAvailbale")
                    uploading_viewSecondHeightConstraints.constant = 40
                    boxCount = boxCount + 1
                    addmore_Btn.isHidden = false
                }
            }else if arrSelectedImg.count == 2 {
                if (arrSelectedImg.index(forKey: "imageSecond") != nil){
                    print("imageSecondimageAvailbale")
                    uploding_viewThirdHeightConstraints.constant = 40
                    boxCount = boxCount + 1
                    addmore_Btn.isHidden = false
                }
            }else if arrSelectedImg.count == 3 {
                if (arrSelectedImg.index(forKey: "imageThird") != nil){
                    print("imageThirdimageAvailbale")
                    upload_viewFourthHeightConstraints.constant = 40
                    boxCount = boxCount + 1
                    addmore_Btn.isHidden = true
                }
            }
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please select above image!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let exitVc = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireBackView") as? QuestionNaireBackView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: exitVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        exitVc?.titleLabal.text = "Are you sure want to exit from the process ?"
        exitVc!.exitBtn.addTargetClosure { _ in
            popup.dismiss()
            self.exitBtn()
        }
        exitVc!.continueBtn.addTargetClosure { _ in
            popup.dismiss()
            
        }
        
        present(popup, animated: animated, completion: nil)
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
        
        exitVc?.titleLable.text = "QuestionNaire Update Sucessfully."
        exitVc!.okBtn.addTargetClosure { _ in
            popup.dismiss()
            self.exitBtn()
        }
        
        present(popup, animated: animated, completion: nil)
    }
    
    func showDeleteCustomDialog(animated: Bool = true, sender : Int) {
        
        // Create a custom view controller
        let deleteVc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteConfirmViewController") as? DeleteConfirmViewController
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: deleteVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        deleteVc?.titleLabel.text = "Are you sure you want to delete document."
        deleteVc!.yesBtn.addTargetClosure { _ in
            popup.dismiss()
            self.removeSelectionDocument(sender)
        }
        deleteVc!.noBtn.addTargetClosure { _ in
            popup.dismiss()
        }
        present(popup, animated: animated, completion: nil)
    }
    
    func showDocumentCustomDialog(animated: Bool = true, image : UIImage) {
        
        // Create a custom view controller
        let documentShowVc = self.storyboard?.instantiateViewController(withIdentifier: "SelectionDocumentShowView") as? SelectionDocumentShowView
        
        
        
        // Create the dialog
        let popup = PopupDialog(viewController: documentShowVc!,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        documentShowVc!.crossDocumentBtn.addTargetClosure { _ in
            popup.dismiss()
            
        }
        documentShowVc?.document_ImgView.image = image
        present(popup, animated: animated, completion: nil)
    }
    
    
    // handle notification
    func exitBtn() {
        let loginType = UserDefaults.standard.string(forKey: "loginType")
        if loginType == "1" {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "DoctorHomeViewController") as! DoctorHomeViewController
            self.navigationController?.pushViewController(obj, animated: true)
        }else{
            if indexingValue.questionNaireType == "singUpQuestionNaire"{
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(obj, animated: true)
            }else{
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(obj, animated: true)
            }
        }
    }
    
    func contineBtn() {
        
    }
    
    @IBAction func secondViewDeleteBtn(_ sender: UIButton) {
        if sender.tag == 2 {
            arrSelectedImg.removeValue(forKey: "imageSecond")
            uploading_viewSecondHeightConstraints.constant = 0
            second_crossBtn.isHidden = true
            second_viewDeleteIcon.isHidden = true
            upload_photoSecondLbl.text = "Upload photo"
            boxCount = boxCount - 1
        }else if sender.tag == 3{
            arrSelectedImg.removeValue(forKey: "imageThird")
            uploding_viewThirdHeightConstraints.constant = 0
            upload_photoThirddLbl.text = "Upload photo"
            third_crossBtn.isHidden = true
            third_deleteBtn.isHidden = true
            boxCount = boxCount - 1
        }else if sender.tag == 4{
            arrSelectedImg.removeValue(forKey: "imageFourth")
            upload_viewFourthHeightConstraints.constant = 0
            upload_photoFourthLbl.text = "Upload photo"
            fourth_crossBtn.isHidden = true
            fourth_deleteBtn.isHidden = true
            boxCount = boxCount - 1
        }
    }
    
    @IBAction func actionSaveNextBtn(_ sender: Any) {
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        if  imgToUpload.count == 0 {
            let alert = UIAlertController(title: "Alert", message: "please select one document!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let questionInfo = indexingValue.newBookingQuestionListArr[indexingValue.indexCount]
            print("questionInfo>>>>>",questionInfo)
            let questionImgId = questionInfo["id"] as? Int
            print("question_Id>>>>",questionImgId)
            let questionType = questionInfo["value"] as? String
            print("questionType>>",questionType)
            print(imgToUpload)
            questionNaireAnswer(question_id: questionImgId!.description, type: questionType!, token: loginToken!, profileImg: imgToUpload)
        }
    }
    
    @IBAction func actionSkipBtn(_ sender: Any) {
        if indexingValue.questionType.count == indexingValue.indexValue {
            let loginType = UserDefaults.standard.string(forKey: "loginType")
            if loginType == "1" {
                if indexingValue.questionNaireType == "updateQuestionNaire" {
                    if self.skip != "0" {
                        self.skip_Btn.isEnabled = false
                    }
                    self.back_Btn.isEnabled = false
                    self.showUpdateCustomDialog()
                }else{
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsViewController")as! TermsAndConditionsViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                    print("last index")
                }
            }else {
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
                        self.skip_Btn.isEnabled = false
                    }
                    self.back_Btn.isEnabled = false
                    self.showUpdateCustomDialog()
                }else {
                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
                    self.navigationController?.pushViewController(Obj, animated:true)
                    print("last index")
                }
            }
        }else if indexingValue.questionType[indexingValue.indexValue] == "text"{
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
        indexingValue.indexCount = indexingValue.indexCount + 1
        indexingValue.indexValue = indexingValue.indexValue + 1
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        if indexingValue.questionNaireType == "updateQuestionNaire"{
            showCustomDialog()
        }else if indexingValue.questionNaireType == "complaintQuestionNaire"{
            showCustomDialog()
        }
        else{
            self.navigationController?.popViewController(animated: true)
            indexingValue.indexValue = indexingValue.indexValue - 1
        }
    }
}
