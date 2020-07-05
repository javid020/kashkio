//
//  IsteklerimViewController.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

let helper1 = User(id: nil, login: "+994503456723", password: nil, nickname: "Javid Abbasov", latitude: nil, longitude: nil, points: 249, badge: nil)
let helper2 = User(id: nil, login: "+994506594857", password: nil, nickname: "Javid Abbasov", latitude: nil, longitude: nil, points: 125, badge: nil)

let helpers = [helper1, helper2]

let waterRequest = WaterRequest(id: nil, initator: helper1, createdDate: nil, availTill: nil, latitude: nil, longitude: nil, requestType: 1, additionalInfo: "Salam mene komek edin")

//let istekler = [Istek(fullname: "Javid Abbasov", info: "Salam, help me", helpers: [helper1, helper2]), Istek(fullname: "Javid Abbasov", info: "Necesiz, help me", helpers: [helper3, helper4])]

let istekler = [waterRequest, waterRequest]

class IsteklerimViewController: UITableViewController {
    
    var selectedIndex = -1
    
    
    var waterRequest: WaterRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "pen"), style: .plain, target: self, action: #selector(newIstekPressed))
        
    }
    
    @objc func newIstekPressed() {
        let storyboard = UIStoryboard(name: "Others", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "NewIstekViewController") as! NewIstekViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension IsteklerimViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return istekler.count
    }

            
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor)
        ])
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == selectedIndex {
            return CGFloat(250 + helpers.count * 60)
        }
        
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "isteklerimID") as? IsteklerimTableViewCell else { return UITableViewCell()}

        cell.setup(istek: istekler[indexPath.row], id: indexPath.row)
        cell.selectionStyle = .none
        cell.isteklerimEventDelegate = self
        cell.helpers = [] //TODO:- fix it
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

extension IsteklerimViewController: IsteklerimEvent {
    func accept(id: Int) {
        print("Accepted")
        let alert = UIAlertController(title: "Success", message: "Uğurla başa çatdı", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            alert.dismiss(animated: true)
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func decline(id: Int) {
        NetworkManager.shared.closeWaterRequests(waterRequestID: id) { result in
            switch result {
            
            case .success(_):
                print("ok")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func call(id: Int) {
        guard let number = URL(string: "tel://" + "+994504800468") else { return }
        UIApplication.shared.open(number)
    }
    
    
}
