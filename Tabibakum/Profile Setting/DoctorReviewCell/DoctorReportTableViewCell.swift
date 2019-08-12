//
//  DoctorReportTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 12/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class DoctorReportTableViewCell: UITableViewCell {

    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var userName_Lbl: UILabel!
    @IBOutlet weak var date_Lbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        profile_imgView.layer.cornerRadius = profile_imgView.frame.height/2
       profile_imgView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
