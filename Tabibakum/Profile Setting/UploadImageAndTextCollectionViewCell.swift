//
//  UploadImageAndTextCollectionViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 10/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class UploadImageAndTextCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var docuement_view: UIView!
    
    @IBOutlet weak var documentImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       docuement_view.layer.cornerRadius = 10
       docuement_view.clipsToBounds = true
    }
}
