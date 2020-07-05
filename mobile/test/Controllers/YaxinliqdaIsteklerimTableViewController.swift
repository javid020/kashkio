//
//  YaxinliqdaIsteklerimTableViewController.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit


class YaxinliqdaIsteklerimTableViewController: UITableViewController {

    var selectedIndex = -1
    
    var waterRequests: [WaterRequest] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getWaterRequests(userID: (currentUser?.id!)!) { [weak self] result in
            switch result {
            case .success(let waterRequests):
                print(waterRequests)
                self?.waterRequests = waterRequests.filter { $0.initiator?.id != currentUser?.id }.reversed()
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc func newIstekPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "NewIstekViewController") as! NewIstekViewController


        navigationController?.pushViewController(vc, animated: true)
    }
}


extension YaxinliqdaIsteklerimTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waterRequests.count
//        return iskterler.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == selectedIndex {
            return 450
        }

        return 200
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "isteklerimID") as? ZengEtTableViewCell else { return UITableViewCell()}

//        cell.setup(istek: istekler[indexPath.row], id: indexPath.row)
        cell.setup(istek: waterRequests[indexPath.row], id: indexPath, isOpen: selectedIndex == indexPath.row)
        cell.selectionStyle = .none
        cell.yardimEtDelegate = self
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension YaxinliqdaIsteklerimTableViewController: YardimEtPressed {
    
    func yardimEtPrressed(id: Int, indexPath: IndexPath) {

        NetworkManager.shared.applyForHelp(waterRequestID: id, userID: currentUser?.id! ?? -1) { result in
            
            switch result {
            case .success(_):
                let alert = UIAlertController(title: "Success", message: "Uğurla başa çatdı", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default) { action in
                    alert.dismiss(animated: true)
                }
                
                
                
                self.waterRequests.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
                alert.addAction(ok)
                self.present(alert, animated: true)
            case .failure(let error):
                print(error)
            }
        }
        

        
    }
    
    
}
