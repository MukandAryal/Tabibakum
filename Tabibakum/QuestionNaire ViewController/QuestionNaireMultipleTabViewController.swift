//
//  QuestionNaireMultipleTabViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 12/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class QuestionNaireMultipleTabViewController: BaseClassViewController {
    @IBOutlet weak var multipleTabCollectionView: UICollectionView!
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var questionNaire_Lbl: UILabel!
    @IBOutlet weak var skip_Btn: UIBarButtonItem!
    @IBOutlet weak var back_Btn: UIBarButtonItem!
    var chooseOptionArr = [String]()
    var questionId = Int()
    var tabStr = String()
    var selectedArr = [String]()
    var skip = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("questionType>>>>>",indexingValue.questionType)
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        let nib = UINib(nibName: "QuestionNaireSingalTabCollectionViewCell", bundle: nil)
        multipleTabCollectionView?.register(nib, forCellWithReuseIdentifier: "QuestionNaireSingalTabCollectionViewCell")
        submit_Btn.backgroundColor = UiInterFace.appThemeColor
        self.navigationItem.rightBarButtonItem?.title = ""
        self.navigationItem.rightBarButtonItem?.isEnabled = false
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
                    if type == "tab2"{
                         self.questionNaire_Lbl.text = specialistObj["question"] as? String
                        let options = specialistObj["options"] as? [[String:AnyObject]]
                        self.questionId = specialistObj["id"] as! Int
                        self.skip = (specialistObj["skip"] as? String)!
                        if self.skip != "0" {
                            self.navigationItem.rightBarButtonItem?.title = "Skip"
                            self.navigationItem.rightBarButtonItem?.isEnabled = true                        }
                        for optionObj in options! {
                            let option = optionObj["options"] as? String
                            self.chooseOptionArr.append(option!)
                            self.multipleTabCollectionView.reloadData()
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
            "text" : tabStr,
            "type" : "tab2",
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
    
    @IBAction func actionBackBtn(_ sender: Any) {
            self.backGroundColorBlur()
            self.questionNaireProcessExit()
            if self.skip != "0" {
                skip_Btn.isEnabled = false
            }
            back_Btn.isEnabled = false
        }
    
    @IBAction func actionSaveAndNext(_ sender: Any){
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
            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsViewController")as! TermsAndConditionsViewController
            self.navigationController?.pushViewController(Obj, animated:true)
            print("last index")
        }else if indexingValue.questionType[indexingValue.indexValue] == "text"{
            print("text")
            let Obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireTextViewController")as! QuestionNaireTextViewController
            self.navigationController?.pushViewController(Obj, animated:true)
        }else  if indexingValue.questionType[indexingValue.indexValue] == "text"{
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
}

extension QuestionNaireMultipleTabViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/2-25, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chooseOptionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "QuestionNaireSingalTabCollectionViewCell", for: indexPath) as! QuestionNaireSingalTabCollectionViewCell
        cell.tab_title.text = chooseOptionArr[indexPath.row]
        if selectedArr.contains(chooseOptionArr[indexPath.row]) {
            cell.tab_title.backgroundColor = UiInterFace.appThemeColor
            cell.tab_title.textColor = UIColor.white
        } else {
            cell.tab_title.backgroundColor = UiInterFace.tabBackgroundColor
            cell.tab_title.textColor = UIColor.black
        }
        return cell
    }
}

extension QuestionNaireMultipleTabViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? QuestionNaireSingalTabCollectionViewCell {
            if selectedArr.contains(chooseOptionArr[indexPath.row]){
                let indexToRemove = selectedArr.firstIndex(where: {$0 == chooseOptionArr[indexPath.row]})
                selectedArr.remove(at: indexToRemove ?? 0)
                selectedCell.tab_title.backgroundColor = UiInterFace.tabBackgroundColor
                selectedCell.tab_title.textColor = UIColor.black
                let strSelectedCategries = selectedArr.joined(separator: ", ")
                tabStr = strSelectedCategries
                print(tabStr)
            }
            else{
                selectedArr.append(chooseOptionArr[indexPath.row])
                selectedCell.tab_title.backgroundColor = UiInterFace.appThemeColor
                selectedCell.tab_title.textColor = UIColor.white
                let strSelectedCategries = selectedArr.joined(separator: ", ")
                tabStr = strSelectedCategries
                print(tabStr)
            }
        }
        self.multipleTabCollectionView.reloadData()
    }
}

