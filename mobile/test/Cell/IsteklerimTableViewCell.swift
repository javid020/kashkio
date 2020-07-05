//
//  IsteklerimTableViewCell.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

protocol DownloadedHelpRequests {
    func downloaded(helpRequests: [AppliedUser])
}

class IsteklerimTableViewCell: UITableViewCell {
    
    @IBOutlet weak var isteklerimImageView: UIImageView!
    @IBOutlet weak var istekNameLabel: UILabel!
    @IBOutlet weak var istekDescriptionLabel: UILabel!
    @IBOutlet weak var istekInfoLabel: UILabel!
    
    
    @IBOutlet weak var isteklerimTableView: UITableView!
    
    var isteklerimEventDelegate: IsteklerimEvent?
    var downloadedHelpersDelegate: DownloadedHelpRequests?
    
    private var helpRequests: [AppliedUser]? // people who are ready to help
    
    var id: Int?
    
    var istek: WaterRequest? {
        didSet {
            istekNameLabel.text = istek?.initiator?.nickname
            
            switch istek?.requestType {
            case 1:
                istekDescriptionLabel.text = "İçməli su"
            case 2:
                istekDescriptionLabel.text = "Gündəlik"
            case 3:
                istekDescriptionLabel.text = "Hamam"
            case 4:
                istekDescriptionLabel.text = "Əkin"
            default:
                istekDescriptionLabel.text = "İçməli su"
            }
            
            downloadHelpRequests()
            
            istekInfoLabel.text = istek?.additionalInfo
            
            isteklerimImageView.image = imageForUser(userID: istek?.initiator?.id)
        }
    }
    
    func downloadHelpRequests() {
        NetworkManager.shared.getListOfAppliedUsers(waterRequestID: istek?.id ?? -1) { result in
            switch result {
            case .success(let helpRequests):
                self.helpRequests = helpRequests
                self.isteklerimTableView.reloadData()
                self.downloadedHelpersDelegate?.downloaded(helpRequests: helpRequests)
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
        return helpRequests?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "isteklerimCellID") as? IsteklerimPeopleTableViewCell else { return UITableViewCell()}

        cell.helperRequest = helpRequests?[indexPath.row]
        cell.selectionStyle = .none
        cell.isteklerimEventDelegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 
        return 60
    }


}

func imageForUser(userID: Int?) -> UIImage? {
    return userID == 2 ? UIImage(named: "javid") : UIImage(named: "jamal")
}

extension IsteklerimTableViewCell: IsteklerimEvent {
    func call(phone: String?) {
        isteklerimEventDelegate?.call(phone: phone)
    }
    
    func accept(waterHelpRequestID: Int) {
        NetworkManager.shared.updateStatusOfWaterRequest(waterRequestID: waterHelpRequestID, status: "ACCEPTED") { result in
            
            switch result {
            case .success(let message):
                print(message)
                self.downloadHelpRequests()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func decline(waterHelpRequestID: Int) {
        NetworkManager.shared.updateStatusOfWaterRequest(waterRequestID: waterHelpRequestID, status: "CLOSED") { result in
            
            switch result {
            case .success(let message):
                print(message)
                self.downloadHelpRequests()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
