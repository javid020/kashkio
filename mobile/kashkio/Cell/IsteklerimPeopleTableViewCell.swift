//
//  IsteklerimPeopleTableViewCell.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

protocol IsteklerimEvent {
    func accept(id: Int)
    func decline(id: Int)
    func call(id: Int)
}

class IsteklerimPeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var helperImageView: UIImageView!
    @IBOutlet weak var helperFullnameLabel: UILabel!
    @IBOutlet weak var helperPhoneLabel: UILabel!
    
    var isteklerimEventDelegate: IsteklerimEvent?
    
    var helper: User? {
        didSet {
            helperFullnameLabel.text = helper?.nickname
            helperPhoneLabel.text = helper?.login
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func callPressed() {
        isteklerimEventDelegate?.call(id: -1)
    }
    
    @IBAction func dismissPressed() {
        isteklerimEventDelegate?.decline(id: -1)
    }
    
    @IBAction func acceptPressed() {
        isteklerimEventDelegate?.accept(id: -1)
    }
    
    
    
}
