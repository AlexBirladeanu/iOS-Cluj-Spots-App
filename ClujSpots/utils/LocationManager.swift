//
//  LocationManager.swift
//  ClujSpots
//
//  Created by Alex Bîrlădeanu on 13.12.2023.
//

import Foundation
import MapKit
import CoreLocation

protocol UserLocationDelegate {
    
    func onUserLocationChanged(location: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var delegate: UserLocationDelegate?
    
    override init() {
        super.init()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setDelegate(_ delegate: UserLocationDelegate) {
        self.delegate = delegate
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
            delegate?.onUserLocationChanged(location: userLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location!")
    }
}
