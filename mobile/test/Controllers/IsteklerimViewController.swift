//
//  IsteklerimViewController.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

class IsteklerimViewController: UITableViewController {
    
    var selectedIndex = -1
    
    var waterRequests: [WaterRequest] = []
    
    var helpRequests: [AppliedUser]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "pen"), style: .plain, target: self, action: #selector(newIstekPressed))
        
        if currentUser == nil {
            NetworkManager.shared.getUserDetails(userID: 2) { result in
                switch result {
                case .success(let user):
                    //                print(user)
                    currentUser = user
                    self.downloadRequests()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.downloadRequests()
    }
    
    @objc func newIstekPressed() {
        let storyboard = UIStoryboard(name: "Others", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "NewIstekViewController") as! NewIstekViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func downloadRequests() {
        // vsegda posilay svoy id
        if let id = currentUser?.id {
            NetworkManager.shared.getWaterRequests(userID: id) { [weak self] result in
                switch result {
                case .success(let waterRequests):
                    self?.waterRequests = waterRequests.filter { $0.initiator?.id == id }
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}


extension IsteklerimViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waterRequests.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == selectedIndex {
            return CGFloat(380)
        }
        
        return 200
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "isteklerimID") as? IsteklerimTableViewCell else { return UITableViewCell()}
        
        cell.setup(istek: waterRequests[indexPath.row], id: indexPath.row)
        cell.selectionStyle = .none
        //        cell.downloadedHelpersDelegate = self
        cell.isteklerimEventDelegate = self
        return cell
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //            tableData[indexPath.section].isOpen.toggle()
        //                    let sections = IndexSet(integer: indexPath.row)
        //                    tableView.reloadSections(sections, with: .automatic)
        
        if selectedIndex == indexPath.row {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
        }
        
        print("secelted index \(selectedIndex)")
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            NetworkManager.shared.closeWaterRequests(waterRequestID: waterRequests[indexPath.row].id!) { result in
                
                switch result {
                case .success(_):
                    print("ok")
                    self.downloadRequests()
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
    }
    
}

extension IsteklerimViewController: DownloadedHelpRequests {
    func downloaded(helpRequests: [AppliedUser]) {
        self.helpRequests = helpRequests
    }
    
    
}

extension IsteklerimViewController: IsteklerimEvent {
    func accept(waterHelpRequestID: Int) {
        
    }
    
    func decline(waterHelpRequestID: Int) {
        
    }
    
    func call(phone: String?) {
        guard let phoneString = phone else {return}
        guard let number = URL(string: "tel://" + phoneString) else { return }
        UIApplication.shared.open(number)
    }
    
}
