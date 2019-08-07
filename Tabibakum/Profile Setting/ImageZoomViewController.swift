//
//  ImageZoomViewController.swift
//  Tabibakum
//
//  Created by osvinuser on 17/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class ImageZoomViewController: BaseClassViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgPhoto: UIImageView!
    var imageStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        let img = Configurator.uploadsImgUrl
        let finalImg = img + imageStr
        imgPhoto.sd_setImage(with: URL(string: finalImg), placeholderImage: UIImage(named: "user_pic"))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
     
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imgPhoto
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
