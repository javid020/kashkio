//
//  ZengEtTableViewCell.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit
import GoogleMaps

protocol YardimEtPressed {
    func yardimEtPrressed(id: Int, indexPath: IndexPath)
}

class ZengEtTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var isteklerimImageView: UIImageViewX!
    @IBOutlet weak var istekNameLabel: UILabel!
    @IBOutlet weak var istekDescriptionLabel: UILabel!
    @IBOutlet weak var istekInfoLabel: UILabel!
    
    @IBOutlet weak var zengEtButton: UIButtonX!
    
    let locationManager = CLLocationManager()
    
    var mapView: GMSMapView!
    
    var yardimEtDelegate: YardimEtPressed?
    
    let imageView2 = UIImageView(image: UIImage(named: "loc"))
    
    
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
            
            istekInfoLabel.text = istek?.additionalInfo

            isteklerimImageView.image = imageForUser(userID: istek?.initiator?.id)
        }
    }
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        setupLocationService(isOpen: false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    func setup(istek: WaterRequest, id: IndexPath, isOpen: Bool) {
        self.istek = istek
        self.indexPath = id

        setupLocationService(isOpen: isOpen)
    }
    
    @IBAction func zengEtPressed() {
        guard let numberString = istek?.initiator?.login else { return }
        guard let number = URL(string: "tel://" + numberString) else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func yardimEtPressed() {
        yardimEtDelegate?.yardimEtPrressed(id: istek?.id! ?? -1, indexPath: indexPath!)
    }
    
    func setupLocationService(isOpen: Bool) {
        locationManager.delegate = self
        locationManager.distanceFilter = 10
        
        let camera = GMSCameraPosition.camera(withLatitude: istek?.latitude ?? 0, longitude: istek?.longitude ?? 0, zoom: 15.0)
        
        mapView = GMSMapView.map(withFrame: frame, camera: camera)
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            mapView.topAnchor.constraint(equalTo: zengEtButton.bottomAnchor, constant: 20)
        ])
        
        
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView2)
        
        NSLayoutConstraint.activate([
            imageView2.widthAnchor.constraint(equalToConstant: 30),
            imageView2.heightAnchor.constraint(equalToConstant: 30),
            imageView2.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            imageView2.centerYAnchor.constraint(equalTo: mapView.centerYAnchor)
        ])
        
        if isOpen {
            imageView2.isHidden = false
        } else {
            imageView2.isHidden = true
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            //            mapView.settings.myLocationButton = false
            mapView.isUserInteractionEnabled = false
            
            //            mapView.settings.compassButton = true
            //            mapView.padding = UIEdgeInsets(top: 10, left: 10, bottom: 1000, right: 10)
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    
}

extension ZengEtTableViewCell: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("ok")
        default:
            return
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        guard let location = locations.first else {
        //            return
        //        }
        
        //        print("Update location...", location)
        
//        mapView.camera = GMSCameraPosition.camera(withLatitude: istek?.latitude ?? 0, longitude: istek?.longitude ?? 0, zoom: 6.0)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ZengEtTableViewCell: GMSMapViewDelegate {
    
}

