//
//  MapViewModel.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/31.
//

// Idea learned from https://kavsoft.dev/SwiftUI_2.0/Advance_MapKit/

struct Place: Identifiable {
    var id = UUID().uuidString
    var placemark: CLPlacemark
}


import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var mapView = MKMapView()
    
    @Published var searchTxt: String = ""
    
    @Published var places: [Place] = []
    
    
    func searchQuery() {
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        MKLocalSearch(request: request).start { (response, _) in
            guard let result = response else {return}
            self.places = result.mapItems.compactMap({(item) -> Place? in
                return Place(placemark: item.placemark)
            })
        }
    }
    
    
    func selectPlace(place: Place) {
        searchTxt = ""
        guard let coordinate = place.placemark.location?.coordinate else {return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.placemark.name ?? "No Name"
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: 10000,
                                                  longitudinalMeters: 10000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func selectPlace(placemark: MKPlacemark) {
        searchTxt = ""
        let coordinate = placemark.coordinate
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: 10000,
                                                  longitudinalMeters: 10000)
        mapView.setRegion(coordinateRegion, animated: true)
//        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    
}
