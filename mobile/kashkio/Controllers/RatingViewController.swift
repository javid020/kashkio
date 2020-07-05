//
//  RatingViewController.swift
//  test
//
//  Created by Javid Abbasov on 04.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    @IBOutlet weak var ratingTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}

extension RatingViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell") as? RatingTableViewCell else { return UITableViewCell()}
        
//        cell.setup(istek: istekler[indexPath.row], id: indexPath.row)
        cell.istek = istekler[indexPath.row]
        cell.selectionStyle = .none

        return cell
        
    }

            
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor)
        ])
    
    
    
    
}

