//
//  HomeViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 27/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    @IBOutlet weak var bookingHistoryTblView: UITableView!
    let cellSpacingHeight: CGFloat = 40

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setDefaults()
        
        bookingHistoryTblView.register(UINib(nibName: "BookingHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingHistoryTableViewCell")
        bookingHistoryTblView.tableFooterView = UIView()
        bookingHistoryTblView.separatorStyle = .none
       // bookingHistoryTblView.separatorInset = .zero
        bookingHistoryTblView.separatorInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
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
}

extension HomeViewController : UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingHistoryTableViewCell") as! BookingHistoryTableViewCell
        return cell
    }

    
}
extension HomeViewController : UITableViewDelegate{
    
}

