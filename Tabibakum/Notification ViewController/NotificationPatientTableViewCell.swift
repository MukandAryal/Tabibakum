//
//  NotificationPatientTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 28/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class NotificationPatientTableViewCell: UITableViewCell {
@IBOutlet weak var background_view: UIView!
    
    @IBOutlet weak var notification_NameLbl: UILabel!
    
    @IBOutlet weak var notification_DescriptionLbl: UILabel!
    @IBOutlet weak var notification_DateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        background_view.layer.cornerRadius = 10
        background_view.clipsToBounds = true
        background_view.layer.borderWidth = 0.5
        background_view.layer.borderColor = UIColor(red: 225/254, green: 228/254, blue: 228/254, alpha: 1.0).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
