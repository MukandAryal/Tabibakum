//
//  BaseClassViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 20/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Alamofire
import SideMenu

class BaseClassViewController: UIViewController {
    var myCustomView: QuestionNaireExitView?
    var myLogoutView: LogOutView?
    var questionNaireUpdateSucessView: QuestionnaireUpdateSucessfullyView?
    var profileUpdateSucessView: ProfileUpdateView?
    var blurView: blurViewController?
    var blurEffectView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func questionNaireProcessExit(){
        if myCustomView == nil { // make it only once
            myCustomView = Bundle.main.loadNibNamed("QuestionNaireExitView", owner: self, options: nil)?.first as? QuestionNaireExitView
            
            myCustomView?.frame = CGRect(x: 20, y: view.frame.height/2-150, width: view.frame.width-40, height:230)
            self.view.addSubview(myCustomView!) // you can omit
        }
    }
    
    func logoutView(){
        if myLogoutView == nil { // make it only once
            myLogoutView = Bundle.main.loadNibNamed("LogOutView", owner: self, options: nil)?.first as? LogOutView
           myLogoutView?.frame = CGRect(x: 20, y: view.frame.height/2-100, width: view.frame.width-40, height:170)
            //            var customView = UIView()
            //            customView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            //            customView.backgroundColor = UIColor.red
            //  blurViewController.addSubview(myLogoutView!)
            //
            // self.addSubview(LogOutView) // you can omit
            //let window = UIApplication.shared.keyWindow!
          //  window.addSubview(myLogoutView!)
         //   let popUpViewController = UIViewController()
            let popUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController" ) as! LoginViewController
            popUpViewController.view.addSubview(myLogoutView!)
           // let vc = blurViewController()
//            popUpViewController.modalPresentationStyle = .overCurrentContext
//            popUpViewController.modalTransitionStyle = .crossDissolve
            present(popUpViewController, animated: true, completion: nil)
        }
    }
    
    func questionNaireProcessUpdateSucessfully(){
        if questionNaireUpdateSucessView == nil { // make it only once
            questionNaireUpdateSucessView = Bundle.main.loadNibNamed("QuestionnaireUpdateSucessfullyView", owner: self, options: nil)?.first as? QuestionnaireUpdateSucessfullyView
            
            questionNaireUpdateSucessView?.frame = CGRect(x: 20, y: view.frame.height/2-150, width: view.frame.width-40, height:230)
            self.view.addSubview(questionNaireUpdateSucessView!) // you can omit
        }
    }
    
    func ProfileUpdateSucessfully(){
        if profileUpdateSucessView == nil { // make it only once
            profileUpdateSucessView = Bundle.main.loadNibNamed("ProfileUpdateView", owner: self, options: nil)?.first as? ProfileUpdateView
            profileUpdateSucessView?.frame = CGRect(x: 20, y: view.frame.height/2-150, width: view.frame.width-40, height:230)
            self.view.addSubview(profileUpdateSucessView!) // you can omit
        }
    }
    
    func backGroundColorBlur(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.6
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    func  backGroundBlurRemove()  {
        blurEffectView.removeFromSuperview()
    }
    
    //    @objc func contineBtn(_ notification: NSNotification) {
    //        print("logout>>")
    //       // if self.skip != "0" {
    //           // skip_Btn.isEnabled = true
    //        //}
    //       // back_Btn.isEnabled = true
    //        self.myCustomView?.isHidden = true
    //        self.backGroundBlurRemove()
    //    }
    //
    //    @objc func doneBtn(_ notification: NSNotification) {
    //        print("exitBtn>>")
    //        let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    //        self.navigationController?.pushViewController(obj, animated: true)
    //    }
    //
    //    @objc func exitBtn(_ notification: NSNotification) {
    //        print("exitBtn>>")
    //        if indexingValue.questionNaireType == "singUpQuestionNaire"{
    //            let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    //            self.navigationController?.pushViewController(obj, animated: true)
    //        }else{
    //            let obj = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    //            self.navigationController?.pushViewController(obj, animated: true)
    //        }
    //    }
    
    func logoutApi(){
        LoadingIndicatorView.show()
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        var api = String()
        api =  Configurator.baseURL + ApiEndPoints.logout + "?token=\(loginToken ?? "")"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                LoadingIndicatorView.hide()
                let resultDict = response.value as? [String: AnyObject]
                if let sucessStr = resultDict!["success"] as? Bool{
                    print(sucessStr)
                    if sucessStr{
                        print("sucessss")
                        let Obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
                        self.navigationController?.pushViewController(Obj, animated:true)
                    }
                }else {
                    let alert = UIAlertController(title: "Alert", message: "sumthing woring!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
}

