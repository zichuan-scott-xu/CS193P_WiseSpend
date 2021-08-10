//
//  MapView.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/31.
//

// Idea learned from https://kavsoft.dev/SwiftUI_2.0/Advance_MapKit/

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    
    @EnvironmentObject var mapData: MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isKind(of: MKUserLocation.self) {return nil}
            else {
                let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                pinAnnotation.tintColor = .red
                pinAnnotation.animatesDrop = true
                pinAnnotation.canShowCallout = true
                return pinAnnotation
            }
        }
        
    }
    
    
}
