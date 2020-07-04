//
//  YaxinliqdaIsteklerimTableViewController.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit


class YaxinliqdaIsteklerimTableViewController: UITableViewController {

    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @objc func newIstekPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "NewIstekViewController") as! NewIstekViewController


        navigationController?.pushViewController(vc, animated: true)
    }
}


extension YaxinliqdaIsteklerimTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return istekler.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == selectedIndex {
            return 450
        }

        return 200
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "isteklerimID") as? ZengEtTableViewCell else { return UITableViewCell()}

        cell.setup(istek: istekler[indexPath.row], id: indexPath.row)
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

}

extension YaxinliqdaIsteklerimTableViewController: YardimEtPressed {
    
    func yardimEtPrressed(id: Int) {

        NetworkManager.shared.applyForHelp(waterRequestID: id, userID: currentUser.id!) { result in
            
            switch result {
            case .success(_):
                print("ok")
            case .failure(let error):
                print(error)
            }
        }
        
//        let alert = UIAlertController(title: "Success", message: "Uğurla başa çatdı", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "OK", style: .default) { action in
//            alert.dismiss(animated: true)
//        }
//
//        alert.addAction(ok)
//        present(alert, animated: true)
        
    }
    
    
}
