//
//  complaintAudioImageTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 17/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class complaintAudioImageTableViewCell: UITableViewCell {
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var auiod_View: UIView!
    @IBOutlet weak var complaintCollectionView: UICollectionView!
     @IBOutlet weak var collectionViewHeight_Constraints: NSLayoutConstraint!
     @IBOutlet weak var audioHeight_Constraints: NSLayoutConstraint!
    
    var complaintArray = [String]()
    var audioFile = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.complaintCollectionView.tag = 22
        auiod_View.layer.cornerRadius = 10
        auiod_View.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func fillCollectionView(with arrayStr: String,audioStr:String) {
        let arr_ = arrayStr.split(separator: ",").map { String($0) }
        self.complaintArray = arr_
        print(self.complaintArray)
        let nib = UINib(nibName: "UploadImageAndTextCollectionViewCell", bundle: nil)
        complaintCollectionView?.register(nib, forCellWithReuseIdentifier: "UploadImageAndTextCollectionViewCell")
       // complaintCollectionView.delegate = self
       // complaintCollectionView.dataSource = self
        self.complaintCollectionView.reloadData()
       if complaintArray.count == 0 {
            collectionViewHeight_Constraints.constant = 0
        }
        if audioStr == ""{
            audioHeight_Constraints.constant = 0
        }
    }
}

//extension complaintAudioImageTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 120, height: 109)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return complaintArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
//            "UploadImageAndTextCollectionViewCell", for: indexPath) as! UploadImageAndTextCollectionViewCell
//        //        if audioFile == ""{
//        //            audioHeight_Constraints.constant = 0
//        //        }
//        let imageStr = Configurator.uploadsImgUrl
//        let img = complaintArray[indexPath.item]
//        let finalImg = imageStr + img
//        cell.documentImgView.sd_setImage(with: URL(string: finalImg), placeholderImage: UIImage(named: "user_pic"))
//        return cell
//    }
//}
//
//extension complaintAudioImageTableViewCell : UICollectionViewDelegate{
//
//}

