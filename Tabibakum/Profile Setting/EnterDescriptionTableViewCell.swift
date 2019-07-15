//
//  EnterDescriptionTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 11/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class EnterDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var prescptionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       descriptionView.layer.cornerRadius = 10
       descriptionView.clipsToBounds = true
       prescptionView.layer.cornerRadius = 10
       prescptionView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
