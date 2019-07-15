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
    @IBOutlet weak var audioImage_view: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let nib = UINib(nibName: "UploadImageAndTextCollectionViewCell", bundle: nil)
        imageCollectionView?.register(nib, forCellWithReuseIdentifier: "UploadImageAndTextCollectionViewCell")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        audioImage_view.layer.cornerRadius = 10
        audioImage_view.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension PatientTextAudioImageTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/2-20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "UploadImageAndTextCollectionViewCell", for: indexPath) as! UploadImageAndTextCollectionViewCell
        return cell
    }
}

extension PatientTextAudioImageTableViewCell : UICollectionViewDelegate{
    
}

