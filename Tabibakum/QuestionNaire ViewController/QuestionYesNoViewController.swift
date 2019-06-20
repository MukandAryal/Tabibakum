//
//  QuestionYesNoViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 11/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class QuestionYesNoViewController: BaseClassViewController {
    @IBOutlet weak var yes_Btn: UIButton!
    @IBOutlet weak var no_Btn: UIButton!
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var questionNaire_Lbl: UILabel!
    @IBOutlet weak var skip_Btn: UIBarButtonItem!
    var selectString = String()
    var questionId = Int()
    var typeStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("questionType>>>>>",indexingValue.questionType)
        yes_Btn.layer.cornerRadius = 5
        yes_Btn.clipsToBounds = true
        no_Btn.layer.cornerRadius = 5
        no_Btn.clipsToBounds = true
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        submit_Btn.backgroundColor = UiInterFace.appThemeColor
        questionNaireApi()
        self.questionNaireProcessExit()
        self.view.backgroundColor = UIColor.gray
        
    
    }
    
    func questionNaireApi(){
        // LoadingIndicatorView.show()
        var api = String()
        if indexingValue.questionNaireType == "complaintQuestionNaire"{
            api = Configurator.baseURL + ApiEndPoints.complaintquestions
        }else{
            api = Configurator.baseURL + ApiEndPoints.patientquestion
        }
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                // LoadingIndicatorView.hide()
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                for specialistObj in dataDict! {
                    print(specialistObj)
                    let type = specialistObj["type"] as? String
                    if type == "yesno"{
                        self.questionNaire_Lbl.text = specialistObj["question"] as? String
                        self.questionId = specialistObj["id"] as! Int
                        let skip = specialistObj["skip"] as? String
                        if skip != "1" {
                            self.navigationItem.rightBarButtonItem = nil
                        }
                    }
                }
        }
    }
    
    func questionNaireAnswerApi(){
        LoadingIndicatorView.show()
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        let param: [String: Any] = [
            "question_id" : questionId,
            "text" : selectString,
            "type" : "yesno",
            "token" : loginToken!
        ]
        
        print(param)
        var api = String()
        if indexingValue.questionNaireType == "complaintQuestionNaire"{
            api = Configurator.baseURL + ApiEndPoints.complaintanswer
        }else{
            api = Configurator.baseURL + ApiEndPoints.patientanswer
        }
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                LoadingIndicatorView.hide()
                let resultDict = response.value as? [String: AnyObject]
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
                        
                    }else {
                        let alert = UIAlertController(title: "Alert", message: "sumthing woring!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
    }
    
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        indexingValue.indexValue = indexingValue.indexValue - 1
    }
    
    @IBAction func actionYesBtn(_ sender: Any) {
        yes_Btn.backgroundColor =  UiInterFace.appThemeColor
        yes_Btn.setTitleColor(UIColor.white, for: .normal)
        no_Btn.backgroundColor =  UIColor(red: 240/254, green: 240/254, blue: 240/254, alpha: 1.0)
        no_Btn.setTitleColor(UIColor.gray, for: .normal)
        selectString = "Yes"
    }
    
    @IBAction func actionNoBtn(_ sender: Any) {
        no_Btn.backgroundColor = UiInterFace.appThemeColor
        no_Btn.setTitleColor(UIColor.white, for: .normal)
        yes_Btn.backgroundColor =  UIColor(red: 240/254, green: 240/254, blue: 240/254, alpha: 1.0)
        yes_Btn.setTitleColor(UIColor.gray, for: .normal)
        selectString = "No"
    }
    
    @IBAction func actionSkipBtn(_ sender: Any) {
        if indexingValue.questionType.count == indexingValue.indexValue {
            if indexingValue.updateQuestionNaire == 2 {
                let Obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
                self.navigationController?.pushViewController(Obj, animated:true)
                print("last index")
            }else {
                let Obj = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsViewController")as! TermsAndConditionsViewController
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
    
    @IBAction func actionSaveAndNext(_ sender: Any) {
        if selectString == ""{
            let alert = UIAlertController(title: "Alert", message: "Please choose one!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
            questionNaireAnswerApi()
        }
    }
}
