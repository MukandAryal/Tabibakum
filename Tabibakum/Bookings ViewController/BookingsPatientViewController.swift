//
//  BookingsPatientViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 28/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu

class BookingsPatientViewController: UIViewController {
    @IBOutlet weak var bookingsTblView: UITableView!
    @IBOutlet var booking_View: UIView!
    @IBOutlet weak var delete_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookingsTblView.isHidden = true
        delete_Btn.isHidden = true
        setupSideMenu()
        setDefaults()
        
        bookingsTblView.register(UINib(nibName: "BookingPatientTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingPatientTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setDefaults() {
        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .menuDissolveIn]
        
    }
    
    @IBAction func actionNewComplaintBtn(_ sender: Any) {
        let doctorsObj = self.storyboard?.instantiateViewController(withIdentifier: "AvailableDoctorsViewController") as! AvailableDoctorsViewController
        self.navigationController?.pushViewController(doctorsObj, animated: true)
        
    }
    
}

extension BookingsPatientViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingPatientTableViewCell") as! BookingPatientTableViewCell
        return cell
    }
    
    
}
extension BookingsPatientViewController : UITableViewDelegate{
    
}
