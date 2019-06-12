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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectList_View.layer.borderWidth = 0.5
        selectList_View.layer.borderColor = UIColor.lightGray.cgColor
        selectList_View.layer.cornerRadius = 5
        selectList_View.clipsToBounds = true
        select_txtFld.setLeftPaddingPoints(10)
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
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
                    if type == "list"{
                        self.questionnaire_Lbl.text = specialistObj["question"] as? String
                        let options = specialistObj["options"] as? [[String:AnyObject]]
                        for optionObj in options! {
                            let option = optionObj["options"] as? String
                            self.listQuestionNaireArr.append(option!)
                        }
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
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionYesNoViewController") as? QuestionYesNoViewController
        self.navigationController?.pushViewController(obj!, animated: true)
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSelectBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        self.configureDropDown(tag: 1)
        self.dropDownSingle.show()
    }
    
    @IBAction func actionSubmitBtn(_ sender: UIButton) {
        
    }
}

