//
//  QueestionNaireImgeAndTextViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 12/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class QueestionNaireImgeAndTextViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadProblem_txtView: UITextView!
    @IBOutlet weak var questionNaire_Lbl: UILabel!
    @IBOutlet weak var uploadImg_ViewFirst: UIView!
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
    @IBOutlet weak var upload_photoFirstLbl: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadProblem_txtView.layer.cornerRadius = 5
        uploadProblem_txtView.clipsToBounds = true
        uploadProblem_txtView.layer.borderWidth = 0.5
        uploadProblem_txtView.layer.borderColor = UIColor.lightGray.cgColor
        
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
        uploading_viewSecondHeightConstraints.constant = 40
        secondCamara_heightConstrants.constant = 30
        secondupload_txtHeightCons.constant = 15
        uploding_viewThirdHeightConstraints.constant = 0
        upload_viewFourthHeightConstraints.constant = 0
        thirdCamera_heightConstraints.constant = 0
        fourthCamera_heightConstraints.constant = 0
        thiedupload_txtThirdHeightCons.constant = 0
        upload_txtFourrthHeightCons.constant = 0
        upload_txtFiveHeightConstraints.constant = 0
        upload_viewFiveHeightConstraints.constant = 0
        fivethCamera_heightConstraints.constant = 0
        five_crossIcon.isHidden = true
        five_deleteIcon.isHidden = true
        cross_btn.isHidden = true
        delete_Btn.isHidden = true
        audionCross_Icon.isHidden = true
        third_DeleteBtn.isHidden = true
        fourth_DeleteBtn.isHidden = true
        third_crossIconBtn.isHidden = true
        fourth_crossIconBtn.isHidden = true
        questionNaireApi()
    }
    
    func questionNaireApi(){
        LoadingIndicatorView.show()
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let api = Configurator.baseURL + ApiEndPoints.patientquestion + "?id=\(userId)"
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
                        // self.questionNaire_Lbl.text = specialistObj["question"] as? String
                    }
                }
        }
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
        if firstUpload_imgBtn.tag == 222{
            upload_photoFirstLbl.text = "PatientAudio.mp3"
            audionCross_Icon.isHidden = false
        }else if secondUpload_ImgBtn.tag == 333{
            upload_photoSecondLbl.text = "Document 1.jpg"
            cross_btn.isHidden = false
            delete_Btn.isHidden = false
            secondView_tralingConstraints.constant = 60
        }else if thirdUpload_ImgBtn.tag == 444{
            upload_photoThirddLbl.text = "Document 2.jpg"
            third_crossIconBtn.isHidden = false
            third_DeleteBtn.isHidden = false
            thirdView_tralingConstraints.constant = 60
        }else if fourthUpload_ImgBtn.tag == 555{
            upload_photoFourthLbl.text = "Document 3.jpg"
            fourth_DeleteBtn.isHidden = false
            fourth_crossIconBtn.isHidden = false
            fourth_viewTralingConstraints.constant = 60
        }else{
            upload_fivePhotoLbl.text = "Document 4.jpg"
            five_deleteIcon.isHidden = false
            five_crossIcon.isHidden = false
            five_viewTralingConstraints.constant = 60
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionAddMoreBtn(_ sender: Any) {
        if firstUpload_imgBtn.tag == 222{
            uploading_viewSecondHeightConstraints.constant = 40
            secondupload_txtHeightCons.constant = 15
            secondCamara_heightConstrants.constant = 30
        }else if secondUpload_ImgBtn.tag == 333 {
            uploding_viewThirdHeightConstraints.constant = 40
            thiedupload_txtThirdHeightCons.constant = 15
            thirdCamera_heightConstraints.constant = 30
        }else if thirdUpload_ImgBtn.tag == 444 {
            upload_viewFourthHeightConstraints.constant = 40
            upload_txtFourrthHeightCons.constant = 15
            fourthCamera_heightConstraints.constant = 30
        }else if fourthUpload_ImgBtn.tag == 555 {
            upload_txtFiveHeightConstraints.constant = 40
            upload_viewFiveHeightConstraints.constant = 15
            fivethCamera_heightConstraints.constant = 30
            five_crossIcon.isHidden = true
            addmore_Btn.isHidden = true
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please select above image!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionFirstImgUploadBtn(_ sender: Any) {
        firstUpload_imgBtn.tag = 222
        secondUpload_ImgBtn.tag = 1
        thirdUpload_ImgBtn.tag = 2
        fourthUpload_ImgBtn.tag = 3
        showAlert()
    }
    
    @IBAction func actionSeconfImgUploadBtn(_ sender: Any) {
        secondUpload_ImgBtn.tag = 333
        firstUpload_imgBtn.tag = 4
        thirdUpload_ImgBtn.tag = 5
        fourthUpload_ImgBtn.tag = 6
        showAlert()
    }
    
    @IBAction func upload_thirdImgBtn(_ sender: Any) {
        thirdUpload_ImgBtn.tag = 444
        firstUpload_imgBtn.tag = 7
        secondUpload_ImgBtn.tag = 8
        fourthUpload_ImgBtn.tag = 9
        showAlert()
    }
    
    @IBAction func upload_fourthImgBtn(_ sender: Any) {
        fourthUpload_ImgBtn.tag = 555
        firstUpload_imgBtn.tag = 10
        secondUpload_ImgBtn.tag = 11
        thirdUpload_ImgBtn.tag = 12
        showAlert()
    }
    @IBAction func upload_fiveImgBtn(_ sender: Any) {
        fiveUploading_ImgBtn.tag = 666
        firstUpload_imgBtn.tag = 13
        secondUpload_ImgBtn.tag = 14
        thirdUpload_ImgBtn.tag = 15
        fourthUpload_ImgBtn.tag = 16
        showAlert()
    }
    
    @IBAction func actionSaveNextBtn(_ sender: Any) {
        
    }
    
    
    @IBAction func actionSkipBtn(_ sender: Any) {
        
    }
    
    @IBAction func actionAudio_crossIcon(_ sender: Any) {
        upload_photoFirstLbl.text = "Upload audio"
        audionCross_Icon.isHidden = true
    }
    
    
    @IBAction func actionCrossBtn(_ sender: Any) {
        upload_photoSecondLbl.text = "Upload photo"
        cross_btn.isHidden = true
    }
    
    @IBAction func actionDeleteBtn(_ sender: Any) {
        uploading_viewSecondHeightConstraints.constant = 0
        secondupload_txtHeightCons.constant = 0
        secondCamara_heightConstrants.constant = 0
        delete_Btn.isHidden = true
    }
    
    @IBAction func actionThird_crossBtn(_ sender: Any) {
        upload_photoThirddLbl.text = "Upload photo"
        third_crossIconBtn.isHidden = true
    }
    
    @IBAction func actionThird_deleteBtn(_ sender: Any) {
        uploding_viewThirdHeightConstraints.constant = 0
        thiedupload_txtThirdHeightCons.constant = 0
        thirdCamera_heightConstraints.constant = 0
        third_DeleteBtn.isHidden = true
    }
    
    @IBAction func actionFourth_deleteBtn(_ sender: Any) {
        upload_viewFourthHeightConstraints.constant = 0
        upload_txtFourrthHeightCons.constant = 0
        fourthCamera_heightConstraints.constant = 0
        fourth_DeleteBtn.isHidden = true
    }
    
    @IBAction func fourthCross_Btn(_ sender: Any) {
        upload_photoFourthLbl.text = "Upload photo"
        fourth_crossIconBtn.isHidden = true
    }
    @IBAction func actionfiveCrossIcon(_ sender: Any) {
        upload_fivePhotoLbl.text = "Upload photo"
        five_crossIcon.isHidden = true
    }
    
    
    @IBAction func actionFiveDeleteBtn(_ sender: Any) {
        upload_txtFiveHeightConstraints.constant = 0
        upload_viewFiveHeightConstraints.constant = 0
        fivethCamera_heightConstraints.constant = 0
        five_crossIcon.isHidden = true
    }
    
    
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
