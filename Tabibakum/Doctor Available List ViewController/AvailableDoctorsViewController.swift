//
//  AvailableDoctorsViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class AvailableDoctorsViewController: UIViewController {

    @IBOutlet weak var availbleDoctorsTblView: UITableView!
    @IBOutlet weak var search_View: UIView!
    @IBOutlet weak var search_txtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        availbleDoctorsTblView.register(UINib(nibName: "AvailableDoctorsTableViewCell", bundle: nil), forCellReuseIdentifier: "AvailableDoctorsTableViewCell")
        availbleDoctorsTblView.tableFooterView = UIView()
        search_View.layer.cornerRadius = search_View.frame.height/2
        search_View.clipsToBounds = true
        search_View.layer.borderWidth = 0.5
        search_View.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func actionBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AvailableDoctorsViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableDoctorsTableViewCell") as! AvailableDoctorsTableViewCell
        return cell
    }
}

extension AvailableDoctorsViewController : UITableViewDelegate{
    
}
