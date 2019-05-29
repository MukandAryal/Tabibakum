//
//  WelcomeViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 22/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpPatientBtn: UIButton!
    @IBOutlet weak var signUpDoctorBtn: UIButton!
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
       loginBtn.layer.cornerRadius = loginBtn.frame.height/2
        loginBtn.clipsToBounds = true
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.white.cgColor
        signUpPatientBtn.layer.cornerRadius = signUpPatientBtn.frame.height/2
        signUpPatientBtn.clipsToBounds = true
        signUpPatientBtn.layer.borderWidth = 1
        signUpPatientBtn.layer.borderColor = UIColor.white.cgColor
         signUpDoctorBtn.layer.cornerRadius = signUpDoctorBtn.frame.height/2
        signUpDoctorBtn.clipsToBounds = true
        signUpDoctorBtn.layer.borderWidth = 1
        signUpDoctorBtn.layer.borderColor = UIColor.white.cgColor
        
        let attributedText = NSMutableAttributedString(string: "Welcome to ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)])
        
        attributedText.append(NSAttributedString(string: "Tabibakum", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        welcomeLbl.attributedText = attributedText
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

    }
    
    
    // MARK: - Button Action
    @IBAction func actionLoginBtn(_ sender: Any) {
        let loginBtn = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginBtn
            , animated:true)
    }
    
    @IBAction func actionSignUpPatient(_ sender: Any) {
        let signUpBtn = self.storyboard?.instantiateViewController(withIdentifier: "SingUpViewController") as! SingUpViewController
        
        self.navigationController?.pushViewController(signUpBtn
            , animated:true)
    }
    
    @IBAction func actionSignUpDoctor(_ sender: Any) {
        let signUpBtn = self.storyboard?.instantiateViewController(withIdentifier: "SignUpAsDoctorViewController") as! SignUpAsDoctorViewController
        self.navigationController?.pushViewController(signUpBtn
            , animated:true)
    }
}
