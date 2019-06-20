//
//  BookAppoinmentViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 20/06/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class BookAppoinmentViewController: UIViewController {
    @IBOutlet weak var bookingDateCollectionView: UICollectionView!
    @IBOutlet weak var submit_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submit_Btn.layer.cornerRadius = submit_Btn.frame.height/2
        submit_Btn.clipsToBounds = true
        let nib = UINib(nibName: "BookAppoinmentCollectionViewCell", bundle: nil)
        bookingDateCollectionView?.register(nib, forCellWithReuseIdentifier: "BookAppoinmentCollectionViewCell")
        submit_Btn.backgroundColor = UiInterFace.appThemeColor
        bookingDateCollectionView.layer.cornerRadius = 5
        bookingDateCollectionView.clipsToBounds = true
        bookingDateCollectionView.layer.borderWidth = 0.5
        bookingDateCollectionView.layer.borderColor = UiInterFace.tabBackgroundColor.cgColor
        
    }
}

extension BookAppoinmentViewController : UICollectionViewDelegate{
    
}

extension BookAppoinmentViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "BookAppoinmentCollectionViewCell", for: indexPath) as! BookAppoinmentCollectionViewCell
        return cell
    }
    
    
}
