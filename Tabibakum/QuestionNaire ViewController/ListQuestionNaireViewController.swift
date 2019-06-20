//
//  ListQuestionNaireViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 11/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class ListQuestionNaireViewController: UIViewController {
    @IBOutlet weak var questionnaire_Lbl: UILabel!
    @IBOutlet weak var selectList_View: UIView!
    @IBOutlet weak var select_txtFld: UITextField!
    @IBOutlet weak var lbl_line: UILabel!
    @IBOutlet weak var submit_Btn: UIButton!
    
    let dropDownSingle = DropDown()
    var listQuestionNaireArr = [String]()
    var questionId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("questionType>>>>>",indexingValue.questionType)
        selectList_View.layer.borderWidth = 0.5
        selectList_View.layer.borderColor = UIColor.lightGray.cgColor
        selectList_View.layer.cornerRadius = 5
        selectList_View.clipsToBounds = true
        select_txtFld.setLeftPaddingPoints(10)
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        submit_Btn.backgroundColor = UiInterFace.appThemeColor
        questionNaireApi()
    }
    
    func questionNaireApi(){
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
                    if type == "list"{
                        self.questionnaire_Lbl.text = specialistObj["question"] as? String
                        self.questionId = specialistObj["id"] as! Int
                        let skip = specialistObj["skip"] as? String
                        if skip != "1" {
                            self.navigationItem.rightBarButtonItem = nil
                        }
                        let options = specialistObj["options"] as? [[String:AnyObject]]
                        for optionObj in options! {
                            let option = optionObj["options"] as? String
                            self.listQuestionNaireArr.append(option!)
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
            "text" : select_txtFld.text!,
            "type" : "list",
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
                        
                    indexingValue.indexValue = indexingValue.indexValue + 1
                    
                }else {
                    let alert = UIAlertController(title: "Alert", message: "sumthing woring!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
}

func configureDropDown(tag:Int) {
    self.dropDownSingle.backgroundColor = UIColor.white
    self.dropDownSingle.dismissMode  = .automatic
    dropDownSingle.selectionBackgroundColor = UIColor(red: 234/255, green: 245/255, blue: 255/255, alpha: 1.0)
    
    if tag == 1 {
        dropDownSingle.anchorView = self.lbl_line
        dropDownSingle.dataSource = listQuestionNaireArr
        dropDownSingle.width = self.selectList_View.frame.size.width
        dropDownSingle.selectionBackgroundColor = UIColor.clear
    }
    dropDownSingle.selectionAction = { [unowned self] (index: Int, item: String) in
        if tag == 1 {
            self.select_txtFld.text = item
            self.select_txtFld.textColor = .black
        }
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
    self.navigationController?.popViewController(animated: true)
    indexingValue.indexValue = indexingValue.indexValue - 1
}

@IBAction func actionSelectBtn(_ sender: UIButton) {
    self.view.endEditing(true)
    self.configureDropDown(tag: 1)
    self.dropDownSingle.show()
}

@IBAction func actionSubmitBtn(_ sender: UIButton) {
    if select_txtFld.text == ""{
        let alert = UIAlertController(title: "Alert", message: "Please choose one!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }else {
        questionNaireAnswerApi()
    }
}
}

