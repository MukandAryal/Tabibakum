//
//  ReviewTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var background_view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        background_view.layer.cornerRadius = 10
        background_view.clipsToBounds = true
        background_view.layer.borderWidth = 0.5
        background_view.layer.borderColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        profile_imgView.layer.cornerRadius = profile_imgView.frame.height/2
        profile_imgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
