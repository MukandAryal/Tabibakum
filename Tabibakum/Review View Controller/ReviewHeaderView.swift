//
//  ReviewHeaderView.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class ReviewHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var Userprofile_imgView: UIImageView!
    
    @IBOutlet weak var userName_Lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Userprofile_imgView.layer.cornerRadius = Userprofile_imgView.frame.height/2
        Userprofile_imgView.clipsToBounds = true
        
    }
}
