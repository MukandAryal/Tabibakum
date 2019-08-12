//
//  PatientTextAudioImageTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 11/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class PatientTextAudioImageTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var patientQuestionLbl: UILabel!
    var array = [String]()
    var audioFile = String()
    @IBOutlet weak var audioHeight_Constraints: NSLayoutConstraint!
    @IBOutlet weak var text_lbl: UILabel!
    @IBOutlet weak var audio_View: UIView!
    @IBOutlet weak var collectionViewHeight_Constraints: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     imageCollectionView.tag = 44
     audio_View.layer.cornerRadius = 10
     audio_View.clipsToBounds = true
     
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func fillCollectionView(with arrayStr: String,audioStr:String) {
        let arr_ = arrayStr.split(separator: ",").map { String($0) }
        self.array = arr_
        print(self.array)
        let nib = UINib(nibName: "UploadImageAndTextCollectionViewCell", bundle: nil)
        imageCollectionView?.register(nib, forCellWithReuseIdentifier: "UploadImageAndTextCollectionViewCell")
        self.imageCollectionView.reloadData()
        if array.count == 0 {
            collectionViewHeight_Constraints.constant = 0
        }
        if audioStr == ""{
            audioHeight_Constraints.constant = 0
        }
    }
}






