//
//  ZengEtTableViewCell.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit
import GoogleMaps

protocol YardimEtPressed {
    func yardimEtPrressed(id: Int)
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
    
    var istek: WaterRequest? {
        didSet {
            istekNameLabel.text = "lkalsdklkasd"
            istekDescriptionLabel.text = "aksldklskdlklkld"
        }
    }
    
    var id: Int?
    
    
    
    override func awakeFromNib() {
        setupLocationService()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupLocationService() {
        locationManager.delegate = self
        locationManager.distanceFilter = 10
        
        let camera = GMSCameraPosition.camera(withLatitude: 44, longitude: 49, zoom: 6.0)
        
        mapView = GMSMapView.map(withFrame: frame, camera: camera)
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            mapView.topAnchor.constraint(equalTo: zengEtButton.bottomAnchor, constant: 20)
        ])
        
//        sendSubviewToBack(mapView)
                
        let position = CLLocationCoordinate2D(latitude: 49.22318, longitude: 16.59972)
        let marker = GMSMarker(position: position)
//        marker.title = "London"
        //        marker.snippet = "Salam"
        marker.appearAnimation = .pop
        marker.icon = UIImage(named: "house")
        marker.map = mapView
        
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
        guard let location = locations.first else {
            return
        }
        
        print("Update location...", location)
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ZengEtTableViewCell: GMSMapViewDelegate {
    
}

