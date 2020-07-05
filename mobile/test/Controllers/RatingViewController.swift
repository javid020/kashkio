//
//  RatingViewController.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    @IBOutlet weak var ratingTableView: UITableView!
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getAllUsers { result in
            switch result {
            case .success(let users):
                self.users = users
                self.ratingTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

extension RatingViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell") as? RatingTableViewCell else { return UITableViewCell()}
        
//        cell.setup(istek: istekler[indexPath.row], id: indexPath.row)
        cell.helper = users[indexPath.row]
//        cell.setup(istek: users[indexPath.row], id: indexPath.row)
        cell.selectionStyle = .none

        return cell
        
    }
    
    
    
    
}

