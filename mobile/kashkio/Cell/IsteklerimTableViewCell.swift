//
//  IsteklerimTableViewCell.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

class IsteklerimTableViewCell: UITableViewCell {
    
    @IBOutlet weak var isteklerimImageView: UIImageView!
    @IBOutlet weak var istekNameLabel: UILabel!
    @IBOutlet weak var istekDescriptionLabel: UILabel!
    @IBOutlet weak var istekInfoLabel: UILabel!
    
    
    @IBOutlet weak var isteklerimTableView: UITableView!
    
    var isteklerimEventDelegate: IsteklerimEvent?
    
    
    
    var istek: WaterRequest? {
        didSet {
            istekNameLabel.text = istek?.initator?.nickname
            istekDescriptionLabel.text = istek?.additionalInfo
        }
    }
    
    var helpers: [User]? {
        didSet {
            isteklerimTableView.reloadData()
        }
    }
    
    var id: Int?
    
    func setup(istek: WaterRequest, id: Int) {
        self.istek = istek
        self.id = id
    }
    
    override func awakeFromNib() {
        isteklerimTableView.delegate = self
        isteklerimTableView.dataSource = self
    }
    
}

extension IsteklerimTableViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpers?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "isteklerimCellID") as? IsteklerimPeopleTableViewCell else { return UITableViewCell()}

        cell.helper = helpers?[indexPath.row]
        cell.selectionStyle = .none
        cell.isteklerimEventDelegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }


}

extension IsteklerimTableViewCell: IsteklerimEvent {
    func accept(id: Int) {
        isteklerimEventDelegate?.accept(id: id)
    }
    
    func decline(id: Int) {
        isteklerimEventDelegate?.decline(id: id)
    }
    
    func call(id: Int) {
        isteklerimEventDelegate?.call(id: id)
    }
    
    
}
