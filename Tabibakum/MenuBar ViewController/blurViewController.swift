//
//  blurViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 25/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class blurViewController: BaseClassViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var customView = UIView()
        customView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        customView.backgroundColor = UIColor.red
        self.view.addSubview(customView)
        customView.addSubview(myLogoutView!)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
