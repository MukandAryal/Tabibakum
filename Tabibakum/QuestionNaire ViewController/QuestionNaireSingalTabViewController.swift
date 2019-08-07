//
//  QuestionNaireSingalTabViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 12/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

struct singalTab {
    struct tabDetails {
        var options: String?
        var isSelected: Bool?
    }
    var tabInfo : [singalTab]
}

class QuestionNaireSingalTabViewController: BaseClassViewController {
    
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var questionNaire_Lbl: UILabel!
    @IBOutlet weak var singalTabCollectionView: UICollectionView!
    @IBOutlet weak var skip_Btn: UIBarButtonItem!
    @IBOutlet weak var back_Btn: UIBarButtonItem!
    var chooseOptionArr = [singalTab.tabDetails]()
    var questionId = Int()
    var tabStr = String()
    var selectedArr = [String]()
    var skip = String()
    var  isSelected : Bool?
    var selectedTabArr = [singalTab.tabDetails]()
    var selectedIndexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("questionType>>>>>",indexingValue.questionType)
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        let nib = UINib(nibName: "QuestionNaireSingalTabCollectionViewCell", bundle: nil)
        singalTabCollectionView?.register(nib, forCellWithReuseIdentifier: "QuestionNaireSingalTabCollectionViewCell")
        submit_Btn.backgroundColor = UiInterFace.appThemeColor
        self.navigationItem.rightBarButtonItem?.title = ""
        self.navigationItem.rightBarButtonItem?.isEnabled = false
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
                self.stopProgress()
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let type = specialistObj["type"] as? String
                    if type == "tab1"{
                        self.questionNaire_Lbl.text = specialistObj["question"] as? String
                        self.questionId = specialistObj["id"] as! Int
                        self.skip = (specialistObj["skip"] as? String)!
                        if self.skip != "0" {
                            self.navigationItem.rightBarButtonItem?.title = "Skip"
                            self.navigationItem.rightBarButtonItem?.isEnabled = true
                        }
                        let options = specialistObj["options"] as? [[String:AnyObject]]
                        for optionObj in options! {
                            var tab = singalTab.tabDetails(
                                options: optionObj["options"] as? String,
                                isSelected: false)
                            // let option = optionObj["options"] as? String
                            self.chooseOptionArr.append(tab)
                            self.singalTabCollectionView.reloadData()
                        }
                    }
                }
        }
    }
    
    func questionNaireAnswerApi(){
        self.showCustomProgress()
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        let questionInfo = indexingValue.newBookingQuestionListArr[indexingValue.indexCount]
        print("questionInfo>>>>>",questionInfo)
        let question_Id = questionInfo["id"]
        print("question_Id>>>>",question_Id)
        let question_Type = questionInfo["value"]
        print("questionType>>",question_Type)
        let param: [String: Any] = [
            "question_id" : question_Id!,
            "text" : tabStr,
            "type" : question_Type!,
            "token" : loginToken!
        ]
        
        print(param)
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
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
               self.stopProgress()
                let resultDict = response.value as? [String: AnyObject]
                if let sucessStr = resultDict!["success"] as? Bool{
                    print(sucessStr)
                    if sucessStr{
                        print("sucessss")
                        indexingValue.indexCount = indexingValue.indexCount + 1
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
                            }else{
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
                                }else{
                                    let Obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
                                    self.navigationController?.pushViewController(Obj, animated:true)
                                    print("last index")
                                }
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
                        
                    }else {
                        let alert = UIAlertController(title: "Alert", message: "sumthing woring!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
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
    
    @IBAction func actionSaveAndNext(_ sender: Any) {
        if tabStr == "" {
            let alert = UIAlertController(title: "Alert", message: "Please choose one!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
            questionNaireAnswerApi()
        }
    }
    
    @IBAction func actionSkipBtn(_ sender: Any) {
        if indexingValue.questionType.count == indexingValue.indexValue {
            let loginType = UserDefaults.standard.string(forKey: "loginType")
            if loginType == "1" {
                if indexingValue.questionNaireType == "DoctorUpdateQuestionNaire" {
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
}

extension QuestionNaireSingalTabViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/2-25, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chooseOptionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionNaireSingalTabCollectionViewCell", for: indexPath) as! QuestionNaireSingalTabCollectionViewCell
        cell.tab_title.text = chooseOptionArr[indexPath.row].options
        if selectedIndexPath != nil && indexPath == selectedIndexPath {
            cell.tab_title.backgroundColor = UiInterFace.appThemeColor
            cell.tab_title.textColor = UIColor.white
        }else{
            cell.tab_title.backgroundColor = UiInterFace.tabBackgroundColor
            cell.tab_title.textColor = UIColor.gray
        }
        return cell
    }
}

extension QuestionNaireSingalTabViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? QuestionNaireSingalTabCollectionViewCell {
            selectedCell.tab_title.backgroundColor = UiInterFace.appThemeColor
            self.selectedIndexPath = indexPath
            tabStr = chooseOptionArr[indexPath.row].options!
            print("tabStr>>>>>>>",tabStr)
            singalTabCollectionView.reloadData()
        }
    }
}

