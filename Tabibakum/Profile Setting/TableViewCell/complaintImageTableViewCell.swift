//
//  complaintImageTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 17/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class complaintImageTableViewCell: UITableViewCell {
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var imageCollectionView:
    UICollectionView!
    var array = [String]()
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillCollectionView(with arrayStr: String) {
        self.imageCollectionView.tag = 11
        let arr_ = arrayStr.split(separator: ",").map { String($0) }
        self.array = arr_
        print(self.array)
        let nib = UINib(nibName: "UploadImageAndTextCollectionViewCell", bundle: nil)
        imageCollectionView?.register(nib, forCellWithReuseIdentifier: "UploadImageAndTextCollectionViewCell")
        self.imageCollectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
