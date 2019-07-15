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
        // Initialization code
        let nib = UINib(nibName: "UploadImageAndTextCollectionViewCell", bundle: nil)
        imageCollectionView?.register(nib, forCellWithReuseIdentifier: "UploadImageAndTextCollectionViewCell")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    func fillCollectionView(with array: String) {
        self.array = [array]
        
        print(array.count)
        docArr.append(array)
        print(docArr.count)
        self.imageCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension UploadTextAndImageTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/2-20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(array.count)
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "UploadImageAndTextCollectionViewCell", for: indexPath) as! UploadImageAndTextCollectionViewCell
        let imageStr = Configurator.imageBaseUrl + array[indexPath.row]
        cell.documentImgView.sd_setImage(with: URL(string: imageStr), placeholderImage: UIImage(named: "user_pic"))
        return cell
    }
    
}

extension UploadTextAndImageTableViewCell : UICollectionViewDelegate{
    
}
