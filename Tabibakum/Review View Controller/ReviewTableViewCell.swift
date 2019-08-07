//
//  ReviewTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 29/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var background_view: UIView!
    @IBOutlet weak var star_View: CosmosView!
    @IBOutlet weak var name_Lbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var date_Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background_view.layer.borderWidth = 2
        background_view.layer.borderColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        profile_imgView.layer.cornerRadius = profile_imgView.frame.height/2
        profile_imgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
