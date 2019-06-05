//
//  dropDownCell.swift
//  EliteMatch
//
//  Created by osvinuser on 15/04/19.
//  Copyright © 2019 Kitlabs-M-0002. All rights reserved.
//

import UIKit

class dropDownCell: UITableViewCell {

    @IBOutlet weak var categaryNameLbl: UILabel!
    @IBOutlet weak var checkBoxView: UIView!
    
    @IBOutlet weak var selectedImgeView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       checkBoxView.layer.borderWidth = 1.0
       checkBoxView.layer.borderColor = UIColor.lightGray.cgColor
       categaryNameLbl.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 0.7)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
