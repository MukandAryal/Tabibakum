//
//  BookingHistoryTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 27/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class BookingHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var userImg_view: UIImageView!
    @IBOutlet weak var user_NameLbl: UILabel!
    @IBOutlet weak var spcialist_Lbl: UILabel!
    @IBOutlet weak var date_Lbl: UILabel!
    @IBOutlet weak var time_lbl: UILabel!
    @IBOutlet weak var background_view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImg_view.layer.cornerRadius = userImg_view.frame.height/2
        userImg_view.clipsToBounds = true
        background_view.layer.cornerRadius = 10
        background_view.clipsToBounds = true
        background_view.layer.borderWidth = 0.5
        background_view.layer.borderColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
