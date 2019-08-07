//
//  UploadTextAndImageTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 08/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class UploadTextAndImageTableViewCell: UITableViewCell {
    @IBOutlet weak var patientQuestionLbl: UILabel!
    @IBOutlet weak var patientAnswerLbl: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var array = [String]()
    var docArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillCollectionView(with arrayStr: String) {
        self.imageCollectionView.tag = 22
        let arr_ = arrayStr.split(separator: ",").map { String($0) }
        self.array = arr_
        print(self.array)
        let nib = UINib(nibName: "UploadImageAndTextCollectionViewCell", bundle: nil)
        imageCollectionView?.register(nib, forCellWithReuseIdentifier: "UploadImageAndTextCollectionViewCell")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        self.imageCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension UploadTextAndImageTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 109)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "UploadImageAndTextCollectionViewCell", for: indexPath) as! UploadImageAndTextCollectionViewCell
        let imageStr = Configurator.uploadsImgUrl
        let img = array[indexPath.item]
         let finalImg = imageStr + img
        cell.documentImgView.sd_setImage(with: URL(string: finalImg), placeholderImage: UIImage(named: "user_pic"))
        return cell
    }
    
}

extension UploadTextAndImageTableViewCell : UICollectionViewDelegate{
    
}
