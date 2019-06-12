//
//  QuestionNaireSingalTabViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 12/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire

class QuestionNaireSingalTabViewController: UIViewController {
    
    @IBOutlet weak var submit_Btn: UIButton!
    @IBOutlet weak var questionNaire_Lbl: UILabel!
    @IBOutlet weak var singalTabCollectionView: UICollectionView!
    var chooseOptionArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        let nib = UINib(nibName: "QuestionNaireSingalTabCollectionViewCell", bundle: nil)
        singalTabCollectionView?.register(nib, forCellWithReuseIdentifier: "QuestionNaireSingalTabCollectionViewCell")
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
                    if type == "tab1"{
                        self.questionNaire_Lbl.text = specialistObj["question"] as? String
                        let options = specialistObj["options"] as? [[String:AnyObject]]
                        for optionObj in options! {
                            let option = optionObj["options"] as? String
                            self.chooseOptionArr.append(option!)
                            self.singalTabCollectionView.reloadData()
                        }
                    }
                }
        }
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSkipBtn(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "QuestionNaireMultipleTabViewController") as! QuestionNaireMultipleTabViewController
        self.navigationController?.pushViewController(obj, animated: true)
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
        cell.tab_title.text = chooseOptionArr[indexPath.row]
        return cell
    }
}

extension QuestionNaireSingalTabViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
