//
//  ViewController.swift
//  test
//
//  Created by Javid Abbasov on 03.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkManager.shared.getWaterRequests(userID: 3) { result in
            switch result {
            case .success(_):
                print("ok")
            case .failure(let error):
                print(error)
            }
        }
        
        setupLocationService()
    }
    
    func setupLocationService() {
        locationManager.delegate = self
        locationManager.distanceFilter = 10
        
        let camera = GMSCameraPosition.camera(withLatitude: 44, longitude: 49, zoom: 6.0)
        
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
                
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
            mapView.settings.myLocationButton = true
            mapView.settings.compassButton = true
            mapView.padding = UIEdgeInsets(top: 10, left: 10, bottom: 120, right: 10)
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    
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

extension ViewController: GMSMapViewDelegate {
    
}
