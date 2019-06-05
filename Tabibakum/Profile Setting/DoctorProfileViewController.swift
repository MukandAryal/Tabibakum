//
//  DoctorProfileViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 30/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class DoctorProfileViewController: UIViewController {
    
    @IBOutlet weak var profile_ImgView: UIImageView!
    @IBOutlet weak var info_view: UIView!
    @IBOutlet weak var bookAppoinment_Btn: UIButton!
    @IBOutlet weak var connectBtn: UIButton!
    
    @IBOutlet weak var appointment_view: UIView!
    
    @IBOutlet weak var whtsApp_View: UIView!
    
    @IBOutlet weak var profile_Btn: UIButton!
    
    @IBOutlet weak var feedback_Btn: UIButton!
    
    @IBOutlet weak var feedBack_View: UIView!
    
    @IBOutlet weak var feedTblView: UITableView!
    
    @IBOutlet weak var addFeedback_Btn: UIButton!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var feedbackView: UIView!
    
    @IBOutlet weak var date_VIew: UIView!
    
    @IBOutlet weak var time_View: UIView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var addFeedback_View: UIView!
    
    @IBOutlet weak var enterFeedBack_View: UIView!
    
    @IBOutlet weak var addFeedbackBtn_Constraints: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile_ImgView.layer.cornerRadius = profile_ImgView.frame.height/2
        profile_ImgView.clipsToBounds = true
        bookAppoinment_Btn.layer.cornerRadius = bookAppoinment_Btn.frame.height/2
        bookAppoinment_Btn.clipsToBounds = true
        info_view.layer.borderColor = UIColor.lightGray.cgColor
        date_VIew.layer.borderWidth = 0.5
        date_VIew.layer.borderColor = UIColor.lightGray.cgColor
        date_VIew.layer.borderWidth = 0.5
        date_VIew.layer.cornerRadius = 10
        date_VIew.clipsToBounds = true
        
        time_View.layer.borderWidth = 0.5
        time_View.layer.borderColor = UIColor.lightGray.cgColor
        time_View.layer.borderWidth = 0.5
        time_View.layer.cornerRadius = 10
        time_View.clipsToBounds = true
        
        
        info_view.layer.shadowColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        info_view.layer.shadowOpacity = 1
        info_view.layer.shadowOffset = .zero
        info_view.layer.shadowRadius = 10
        connectBtn.layer.cornerRadius = connectBtn.frame.height/2
        connectBtn.clipsToBounds = true
        
        profile_Btn.layer.borderColor = UIColor(red: 66/254, green: 153/254, blue: 52/254, alpha: 1.0).cgColor
        profile_Btn.layer.borderWidth = 1
        
        profile_Btn.roundedButton()
        feedback_Btn.roundedButton1()
        
        feedback_Btn.layer.borderColor =  UIColor(red: 66/254, green: 153/254, blue: 52/254, alpha: 1.0).cgColor
        feedback_Btn.layer.borderWidth = 1
        
        addFeedback_Btn.layer.borderColor = UIColor(red: 66/254, green: 153/254, blue: 52/254, alpha: 1.0).cgColor
        addFeedback_Btn.layer.borderWidth = 0.5
        addFeedback_Btn.layer.cornerRadius = addFeedback_Btn.frame.height/2
        addFeedback_Btn.clipsToBounds = true
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = info_view.frame
        rectShape.position = self.info_view.center
        rectShape.path = UIBezierPath(roundedRect: self.info_view.bounds, byRoundingCorners: [.bottomLeft , .bottomRight ,], cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.info_view.layer.mask = rectShape
        
        feedTblView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        feedbackView.isHidden = true
        
        addFeedback_View.layer.borderColor = UIColor.lightGray.cgColor
        addFeedback_View.layer.borderWidth = 0.5
        
        addFeedback_View.layer.cornerRadius = 10
        addFeedback_View.clipsToBounds = true
        
        enterFeedBack_View.layer.borderColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        enterFeedBack_View.layer.borderWidth = 0.5
        
        enterFeedBack_View.layer.cornerRadius = 10
        enterFeedBack_View.clipsToBounds = true
        
        addFeedback_View.isHidden = true
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionProfileBtn(_ sender: Any) {
        profileView.isHidden = false
        feedbackView.isHidden = true
        feedback_Btn.backgroundColor = UIColor.white
        profile_Btn.backgroundColor =  UIColor(red: 188/254, green: 227/254, blue: 182/254, alpha: 1.0)
    }
    
    @IBAction func actionFeedbackBtn(_ sender: Any) {
        profileView.isHidden = true
        feedbackView.isHidden = false
        profile_Btn.backgroundColor = UIColor.white
        feedback_Btn.backgroundColor =  UIColor(red: 188/254, green: 227/254, blue: 182/254, alpha: 1.0)
    }
    @IBAction func actionAddFeedBackBtn(_ sender: Any) {
        addFeedback_View.isHidden = false
        addFeedback_Btn.isHidden = true
        addFeedbackBtn_Constraints.constant = 0
    }
    
    @IBAction func actionCancelBtn(_ sender: Any) {
        addFeedback_View.isHidden = true
        addFeedback_Btn.isHidden = false
        addFeedbackBtn_Constraints.constant = 40
    }
}

extension DoctorProfileViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as! ReviewTableViewCell
        return cell
    }
    
}

extension DoctorProfileViewController : UITableViewDelegate{
    
}

extension UIButton{
    func roundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft ,],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
extension UIButton{
    func roundedButton1(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight],
                                     cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
