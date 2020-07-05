//
//  NewIstekViewController.swift
//  test
//
//  Created by Javid Abbasov on 04.07.2020
//  Copyright © 2020 Javid Abbasov. All rights reserved.
//

import UIKit
import JMMaskTextField_Swift
import GoogleMaps

class NewIstekViewController: UIViewController {
    
    let marker = GMSMarker()
    
    @IBOutlet weak var tesvirTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButtonX!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var teapotImageView: UIImageView!
    @IBOutlet weak var cleaningImageView: UIImageView!
    @IBOutlet weak var babyShowerImageView: UIImageView!
    @IBOutlet weak var plantImageView: UIImageView!
    

    var mapView: GMSMapView!
    
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationService()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(teapotPressed))
        teapotImageView.isUserInteractionEnabled = true
        teapotImageView.addGestureRecognizer(gesture)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(cleaningPressed))
        cleaningImageView.isUserInteractionEnabled = true
        cleaningImageView.addGestureRecognizer(gesture2)
        
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(babyShowerPressed))
        babyShowerImageView.isUserInteractionEnabled = true
        babyShowerImageView.addGestureRecognizer(gesture3)
        
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(plantingPressed))
        plantImageView.isUserInteractionEnabled = true
        plantImageView.addGestureRecognizer(gesture4)
        
        
    }
    
    var selectedItem = 0
    
    @objc func teapotPressed() {
        resetAll()
        selectedItem = 1
        teapotImageView.layer.borderWidth = 2
    }
    
    @objc func babyShowerPressed() {
        resetAll()
        selectedItem = 3
        babyShowerImageView.layer.borderWidth = 2
    }
    
    @objc func plantingPressed() {
        resetAll()
        selectedItem = 4
        plantImageView.layer.borderWidth = 2
    }
    
    func resetAll() {
        teapotImageView.layer.borderWidth = 0;
        cleaningImageView.layer.borderWidth = 0;
        babyShowerImageView.layer.borderWidth = 0;
        plantImageView.layer.borderWidth = 0;
    }
    
    func setupLocationService() {
        locationManager.delegate = self
        locationManager.distanceFilter = 10
        
        let camera = GMSCameraPosition.camera(withLatitude: 44, longitude: 49, zoom: 6.0)
        
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mapView.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -20),
            mapView.topAnchor.constraint(equalTo: tesvirTextField.bottomAnchor, constant: 20)
        ])
        
        let imageView = UIImageView(image: UIImage(named: "house"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        
        
        // Center camera to marker position
        mapView.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 15)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            //            mapView.isUserInteractionEnabled = false
            
            //            mapView.settings.compassButton = true
            //            mapView.padding = UIEdgeInsets(top: 10, left: 10, bottom: 1000, right: 10)
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    @IBAction func gonderPressed() {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
 
        
        let waterRequest = WaterRequest(id: nil, initator: currentUser, createdDate: "\(day)-\(month)-\(year) \(hour):\(minutes):\(seconds)", availTill: "", latitude: currentLocation?.coordinate.latitude, longitude: currentLocation?.coordinate.longitude, requestType: selectedItem, additionalInfo: tesvirTextField.text ?? "")
        
        NetworkManager.shared.addWaterRequest(waterRequest) { result in
            switch result {
            case .success(_):
                print("Success")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    
}

extension NewIstekViewController: CLLocationManagerDelegate {
    
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
        
        currentLocation = location
        
        print("Update location...", location)
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension NewIstekViewController: GMSMapViewDelegate {
    
}


