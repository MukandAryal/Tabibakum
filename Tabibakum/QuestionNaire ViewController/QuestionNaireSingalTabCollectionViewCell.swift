//
//  QuestionNaireSingalTabCollectionViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 12/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class QuestionNaireSingalTabCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tab_title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tab_title.layer.cornerRadius = 5
        tab_title.clipsToBounds = true
    }
}
