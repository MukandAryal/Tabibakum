//
//  PatientQuestionTextTableViewCell.swift
//  Tabibakum
//
//  Created by osvinuser on 11/07/19.
//  Copyright © 2019 osvinuser. All rights reserved.
//

import UIKit

class PatientQuestionTextTableViewCell: UITableViewCell {
    @IBOutlet weak var complaintQuestionLbl: UILabel!
    @IBOutlet weak var complaintAnswerLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
