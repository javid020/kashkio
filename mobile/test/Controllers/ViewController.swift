//
//  ViewController.swift
//  test
//
//  Created by Javid Abbasov on 05.07.2020.
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var mapView: GMSMapView!
    
    var waterRequests: [WaterRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationService()
        
        
        NetworkManager.shared.getWaterRequests(userID: currentUser?.id! ?? -1) { [weak self] result in
            switch result {
            case .success(let waterRequests):
                self?.waterRequests = waterRequests.filter { $0.initiator?.id != currentUser?.id }
                self?.updateMarkers()
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func updateMarkers() {
        waterRequests.forEach { request in
            print(request)
            let position = CLLocationCoordinate2D(latitude: request.latitude ?? 0, longitude: request.longitude ?? 0)
            let marker = GMSMarker(position: position)
            
            marker.title = request.initiator?.nickname
            
            switch request.requestType {
            case 1:
                marker.snippet = "İçməli su"
            case 2:
                marker.snippet = "Gündəlik"
            case 3:
                marker.snippet = "Hamam"
            case 4:
                marker.snippet = "Əkin"
            default:
                marker.snippet = "İçməli su"
            }
            
            
            marker.appearAnimation = .pop
            marker.icon = UIImage(named: "loc")
            marker.map = mapView
            
            
        }
        
    }
    
    func setupLocationService() {
        locationManager.delegate = self
        locationManager.distanceFilter = 10
        
        let camera = GMSCameraPosition.camera(withLatitude: 44, longitude: 49, zoom: 6.0)
        
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
                        
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
        
//        print("Update location...", location)
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        currentUser?.latitude = location.coordinate.latitude
        currentUser?.longitude = location.coordinate.longitude
        
        NetworkManager.shared.updateUserDetails(currentUser!) { result in
        
            switch result {
            case .success(_):
                print("ok")
            case .failure(_):
                print("fail")
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ViewController: GMSMapViewDelegate {
    
}
