//
//  UploadImageAndTextCollectionViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 10/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class UploadImageAndTextCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var documentImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       documentImgView.layer.cornerRadius = 10
       documentImgView.clipsToBounds = true
        
    }
}
