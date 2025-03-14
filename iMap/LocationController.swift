//
//  LocationController.swift
//  iMap
//
//  Created by ksd on 14/03/2025.
//

import Foundation
import CoreLocation

@Observable
class LocationController: NSObject {

    var locationManager: CLLocationManager?

    override init() {
        super.init()
        checkIfLocationIsEnabled()
    }

    func checkIfLocationIsEnabled(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        }
    }

    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
            case .notDetermined:
                print("Not determined")
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorizedAlways:
                print("authorizedAlways")
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
                locationManager.startUpdatingLocation()
            @unknown default:
                print("unknown")
        }
    }
}

extension LocationController: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
            print("Din location er: \(userLocation)")
        }
    }
}
