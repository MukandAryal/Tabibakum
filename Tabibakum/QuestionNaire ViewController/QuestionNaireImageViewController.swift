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

class QuestionNaireImageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

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
        //secondCamara_heightConstrants.constant = 0
       // thirdCamera_heightConstraints.constant = 0
        //fourthCamera_heightConstraints.constant = 0
        //secondupload_txtHeightCons.constant = 0
       // thiedupload_txtThirdHeightCons.constant = 0
       // upload_txtFourrthHeightCons.constant = 0
        second_viewDeleteIcon.isHidden = true
        second_crossBtn.isHidden = true
        first_crossBtn.isHidden = true
        second_crossBtn.isHidden = true
        second_viewDeleteIcon.isHidden = true
        third_crossBtn.isHidden = true
        third_deleteBtn.isHidden = true
        fourth_crossBtn.isHidden = true
        fourth_deleteBtn.isHidden = true
        questionNaireApi()
    }
    
    func questionNaireApi(){
        // LoadingIndicatorView.show()
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let api = Configurator.baseURL + ApiEndPoints.patientquestion + "?id=\(userId)"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                // LoadingIndicatorView.hide()
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let type = specialistObj["type"] as? String
                    if type == "image"{
                    self.questionNaire_Lbl.text = specialistObj["question"] as? String
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
           upload_photoFirstLbl.text = "Document 1.jpg"
           first_crossBtn.isHidden = false
        }else if secondUpload_ImgBtn.tag == 333{
            upload_photoSecondLbl.text = "Document 2.jpg"
            second_viewDeleteIcon.isHidden = false
            second_crossBtn.isHidden = false
            second_viewTralingConstraints.constant = 50
        }else if thirdUpload_ImgBtn.tag == 444{
            upload_photoThirddLbl.text = "Document 3.jpg"
            third_deleteBtn.isHidden = false
            third_crossBtn.isHidden = false
            third_viewTralingConstraints.constant = 50
        }else if fourthUpload_ImgBtn.tag == 555{
            upload_photoFourthLbl.text = "Document 4.jpg"
            fourth_deleteBtn.isHidden = false
            fourth_crossBtn.isHidden = false
            fourth_viewTralingConstraints.constant = 50
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionAddMoreBtn(_ sender: Any) {
         if firstUpload_imgBtn.tag == 222{
            uploading_viewSecondHeightConstraints.constant = 40
          //  secondupload_txtHeightCons.constant = 15
          //  secondCamara_heightConstrants.constant = 30
            second_viewDeleteIcon.isHidden = true
            second_crossBtn.isHidden = true
        }else if secondUpload_ImgBtn.tag == 333 {
            uploding_viewThirdHeightConstraints.constant = 40
            //thiedupload_txtThirdHeightCons.constant = 15
            //thirdCamera_heightConstraints.constant = 30
        }else if thirdUpload_ImgBtn.tag == 444 {
            upload_viewFourthHeightConstraints.constant = 40
           // upload_txtFourrthHeightCons.constant = 15
            //fourthCamera_heightConstraints.constant = 30
            addmore_Btn.isHidden = true
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please select above image!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionFirstImgUploadBtn(_ sender: Any) {
        firstUpload_imgBtn.tag = 222
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
        showAlert()
    }
    
    @IBAction func actionSeconfImgUploadBtn(_ sender: Any) {
      secondUpload_ImgBtn.tag = 333
      firstUpload_imgBtn.tag = 0
      thirdUpload_ImgBtn.tag = 0
      fourthUpload_ImgBtn.tag = 0
       showAlert()
    }
    
    @IBAction func upload_thirdImgBtn(_ sender: Any) {
        thirdUpload_ImgBtn.tag = 444
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
        showAlert()
    }
    
    @IBAction func upload_fourthImgBtn(_ sender: Any) {
        fourthUpload_ImgBtn.tag = 555
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
          showAlert()
    }
    
    @IBAction func actionFirstCrossBtn(_ sender: Any) {
        upload_photoFirstLbl.text = "Upload photo"
        first_crossBtn.isHidden = true
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    @IBAction func actionSecondCrossBtn(_ sender: Any) {
        upload_photoSecondLbl.text = "Upload photo"
        second_crossBtn.isHidden = true
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    @IBAction func secondViewDeleteBtn(_ sender: Any) {
        uploading_viewSecondHeightConstraints.constant = 0
        second_crossBtn.isHidden = true
        second_viewDeleteIcon.isHidden = true
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    @IBAction func actionThirdCrossBtn(_ sender: Any) {
        upload_photoThirddLbl.text = "Upload photo"
        third_crossBtn.isHidden = true
        addmore_Btn.isHidden = false
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    @IBAction func actionFourthCrossBtn(_ sender: Any) {
        upload_photoFourthLbl.text = "Upload photo"
        fourth_crossBtn.isHidden = true
         addmore_Btn.isHidden = false
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    @IBAction func actionThirdDeleteBtn(_ sender: Any) {
        uploding_viewThirdHeightConstraints.constant = 0
        third_crossBtn.isHidden = true
        third_deleteBtn.isHidden = true
        addmore_Btn.isHidden = false
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    @IBAction func actionfourthDeleteBtn(_ sender: Any) {
        upload_viewFourthHeightConstraints.constant = 0
        fourth_crossBtn.isHidden = true
        fourth_deleteBtn.isHidden = true
        firstUpload_imgBtn.tag = 0
        secondUpload_ImgBtn.tag = 0
        thirdUpload_ImgBtn.tag = 0
        fourthUpload_ImgBtn.tag = 0
    }
    
    @IBAction func actionSaveNextBtn(_ sender: Any) {
        if indexingValue.questionType.count == indexingValue.indexValue {
            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "patientSingUpSucessfullyViewController")as! patientSingUpSucessfullyViewController
            self.navigationController?.pushViewController(Obj, animated:true)
            print("last index")
        }else if indexingValue.questionType[indexingValue.indexValue] == "text"{
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
    
    @IBAction func actionSkipBtn(_ sender: Any) {
        
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        indexingValue.indexValue = indexingValue.indexValue - 1
    }
    
}
