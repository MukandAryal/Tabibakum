//
//  ReviewViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import SideMenu

class ReviewViewController: UIViewController {
    @IBOutlet weak var reviewTblView: UITableView!
    var feedBackArr = [doctorFeedbackInfo.feedbackDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setDefaults()
        
        let nibHeaderName = UINib(nibName: "ReviewHeaderView", bundle: nil)
        reviewTblView.register(nibHeaderName, forHeaderFooterViewReuseIdentifier: "ReviewHeaderView")
        
        reviewTblView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
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

extension ReviewViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let headerView = reviewTblView.dequeueReusableHeaderFooterView(withIdentifier: "ReviewHeaderView" ) as! ReviewHeaderView
//        
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as! ReviewTableViewCell
        return cell
    }
    
}

extension ReviewViewController : UITableViewDelegate{

}
