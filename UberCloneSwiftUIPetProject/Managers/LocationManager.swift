//
//  LocationManager.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 10.02.23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var userLocationCoordinate: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func distance(to destination: CLLocationCoordinate2D?) -> Double? {
        guard let selectedLocationCoordinate = destination, let userLocationCoordinate = userLocationCoordinate else { return nil }
        let userLocation = CLLocation(latitude: userLocationCoordinate.latitude, longitude: userLocationCoordinate.longitude)
        let destinationLocation = CLLocation(latitude: selectedLocationCoordinate.latitude, longitude: selectedLocationCoordinate.longitude)
        return userLocation.distance(from: destinationLocation)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userLocationCoordinate = location.coordinate
        manager.stopUpdatingLocation()
    }
}
