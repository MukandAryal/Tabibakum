//
//  singUpPatientWelcomeScreenViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 12/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class singUpPatientWelcomeScreenViewController: BaseClassViewController {
    @IBOutlet weak var welcome_Lbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var next_Btn: UIButton!
    //   var questionType = [String]()
    var descriptionStr = String()
    var questionListArr = [String:AnyObject]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributedText = NSMutableAttributedString(string: "Welcome to ", attributes: [NSAttributedString.Key.font: UIFont(name: "ProximaNova-Regular", size: 30)!])
        
        attributedText.append(NSAttributedString(string: "Tabibakum", attributes: [NSAttributedString.Key.font: UIFont(name: "ProximaNova-Bold", size: 30)!]))
        
        welcome_Lbl.attributedText = attributedText
        next_Btn.layer.cornerRadius = next_Btn.frame.height/2
        next_Btn.clipsToBounds = true
        next_Btn.backgroundColor = UiInterFace.appThemeColor
        questionNaireApi()
        descriptionStr = "Your privacy is crucial for us only your doctor and our employees will see your responses no one else will ever have access to your info unless you give us a full clear permission to do so."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func questionNaireApi(){
        self.showCustomProgress()
        let api = Configurator.baseURL + ApiEndPoints.patientquestion
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                self.stopProgress()
                print(response)
                let resultDict = response.value as? NSDictionary
                let dataDict = resultDict!["data"] as? [[String:AnyObject]]
                if let sucessStr = resultDict!["success"] as? Bool{
                    print(sucessStr)
                    if sucessStr{
                        print("sucessss")
                        indexingValue.questionNaireType = "singUpQuestionNaire"
                        for specialistObj in dataDict! {
                            print(specialistObj)
                            let type = specialistObj["type"] as? String
                            indexingValue.questionType.append(type!)
                            let id = specialistObj["id"] as? Int
                            self.questionListArr["value"] = type as AnyObject
                            self.questionListArr["id"] = id as AnyObject
                            indexingValue.newBookingQuestionListArr.append(self.questionListArr)
                            print("questionList>>>>>>",indexingValue.newBookingQuestionListArr)
                            indexingValue.indexCount = 0
                            print(indexingValue.questionType)
                            indexingValue.indexValue = 0
                        }
                    }else{
                        let alert = UIAlertController(title: "Alert", message: "sumthing went woring please try again!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
    }
    
    @IBAction func actionNextBtn(_ sender: Any) {
        if descriptionStr == "Your privacy is crucial for us only your doctor and our employees will see your responses no one else will ever have access to your info unless you give us a full clear permission to do so."{
            description_Lbl.text = "Welcome to our app the most innovative way to good health care in Iraq"
            descriptionStr = "Welcome to our app the most innovative way to good health care in Iraq"
        }else if descriptionStr == "Welcome to our app the most innovative way to good health care in Iraq"{
            description_Lbl.text = "Answering these questions with the most accurate response possible is the best way for your doctor to give the best care possible."
            descriptionStr = ""
        }else {
        if indexingValue.questionType[indexingValue.indexValue] == "text"{
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
        indexingValue.indexValue = +1
        }
    }
    
}
