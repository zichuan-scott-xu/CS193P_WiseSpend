//
//  LocationManager.swift
//  WiseSpend
//
//  Created by Scott Xu on 5/31/21.
//  Code inspired by https://github.com/azamsharp/NearMeAppSwiftUI/blob/main/NearMe and
//  MapKit tutorial https://www.youtube.com/watch?v=Rhni99ZrLd4&t=2922s
//
import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
    func startUpdates() {
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        DispatchQueue.main.async {
            self.location = location
        }
    }
    
}
