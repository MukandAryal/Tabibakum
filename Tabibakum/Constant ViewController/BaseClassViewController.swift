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

typealias UIButtonTargetClosure = (UIButton) -> ()

class BaseClassViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIFHUD.shared.setGif(named: "dotted_loader.gif")
    }
    
    func logoutView() {
        let title = "Logout"
        let message = "Are you sure you want to Logout?"
        let image = UIImage(named: "signout")
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                image: image,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true,
                                hideStatusBar: true) {
                                    
        }
        
        //        // Create first button
        let buttonOne = CancelButton(title: "Log Out", height: 40) {
            self.signOutAction()
            UserDefaults.standard.removeObject(forKey: "loginPhoneNumber")
            UserDefaults.standard.removeObject(forKey: "loginPasswordNumber")
            popup.dismiss()
        }
        //        // Create second button
        let buttonTwo = DefaultButton(title: "Stay Logged In", height: 40) {
            self.signInAction()
            popup.dismiss()
        }
        //
        buttonOne.titleColor = UIColor.black
        buttonOne.buttonColor = UIColor(red: 240.0/255.0, green: 239.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        buttonTwo.titleColor = UIColor.lightText
        buttonTwo.buttonColor = UIColor(red: 76.0/255.0, green: 176.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        //        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        // Present dialog
        self.present(popup, animated: true, completion: nil)
        
    }
    func signInAction(){
        SideMenuManager.default.menuLeftNavigationController?.dismiss(animated: true, completion: nil)
        
    }
    // SignOut
    func signOutAction(){
        // API CAll
        logoutApi()
    }
    
    func logoutApi(){
        self.showCustomProgress()
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        var api = String()
        api =  Configurator.baseURL + ApiEndPoints.logout + "?token=\(loginToken ?? "")"
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                self.stopProgress()
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
    
    func showAlert(message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func showCustomProgress() {
        GIFHUD.shared.show(withOverlay: true)
        
    }
    
    func stopProgress() {
        GIFHUD.shared.dismiss()
    }
}

extension UIButton {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTargetClosure(closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}
class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}


