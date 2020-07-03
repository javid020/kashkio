//
//  RatingTableViewCell.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var helperImageView: UIImageViewX!
    @IBOutlet weak var helperFullnameLabel: UILabel!
    @IBOutlet weak var helperDescriptionLabel: UILabel!
    
    @IBOutlet weak var komekLabel: UILabel!
    
    
    var istek: WaterRequest? {
        didSet {
//            helperFullnameLabel.text = istek?.fullname
//            helperDescriptionLabel.text = istek?.info
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
