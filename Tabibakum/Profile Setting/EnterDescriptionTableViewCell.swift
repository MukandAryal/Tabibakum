//
//  EnterDescriptionTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 11/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class EnterDescriptionTableViewCell: UITableViewCell,UITextViewDelegate {
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var prescptionView: UIView!
    @IBOutlet weak var precription_txtView: UITextView!
    @IBOutlet weak var description_txtView: UITextView!
        var desStr = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       descriptionView.layer.cornerRadius = 10
       descriptionView.clipsToBounds = true
       prescptionView.layer.cornerRadius = 10
       prescptionView.clipsToBounds = true
       precription_txtView.delegate = self
       description_txtView.delegate = self
       desStr = description_txtView.text
       descriptionView.layer.borderWidth = 0.5
       descriptionView.layer.borderColor = UIColor.lightGray.cgColor
       prescptionView.layer.borderWidth = 0.5
       prescptionView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


