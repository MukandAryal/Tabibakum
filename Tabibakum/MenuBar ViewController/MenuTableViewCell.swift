//
//  MenuTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 27/05/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuBar_Img: UIImageView!
    @IBOutlet weak var menuBar_Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
