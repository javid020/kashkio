//
//  RatingTableViewCell.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var helperImageView: UIImageViewX!
    @IBOutlet weak var helperFullnameLabel: UILabel!
    @IBOutlet weak var helperDescriptionLabel: UILabel!
    
    @IBOutlet weak var komekLabel: UILabel!
    
    var helper: User? {
        didSet {
            helperFullnameLabel.text = helper?.nickname
            helperDescriptionLabel.text = helper?.badge
            komekLabel.text = "\(Int(helper?.points ?? 0))"
            helperImageView.image = imageForUser(userID: helper?.id)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
