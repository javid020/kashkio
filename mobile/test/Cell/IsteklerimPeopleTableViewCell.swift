//
//  IsteklerimPeopleTableViewCell.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

protocol IsteklerimEvent {
    func accept(waterHelpRequestID: Int)
    func decline(waterHelpRequestID: Int)
    func call(phone: String?)
}

class IsteklerimPeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var helperImageView: UIImageView!
    @IBOutlet weak var helperFullnameLabel: UILabel!
    @IBOutlet weak var helperPhoneLabel: UILabel!
    
    var isteklerimEventDelegate: IsteklerimEvent?
    
    var helperRequest: AppliedUser? {
        didSet {
            helperFullnameLabel.text = helperRequest?.appliedUser?.nickname
            helperPhoneLabel.text = helperRequest?.appliedUser?.login
            helperImageView.image = imageForUser(userID: helperRequest?.appliedUser?.id)
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
        isteklerimEventDelegate?.call(phone: helperRequest?.appliedUser?.login)
    }
    
    @IBAction func dismissPressed() {
        isteklerimEventDelegate?.decline(waterHelpRequestID: helperRequest?.id ?? -1)
    }
    
    @IBAction func acceptPressed() {
        isteklerimEventDelegate?.accept(waterHelpRequestID: helperRequest?.id ?? -1)
    }
    
    
    
}
