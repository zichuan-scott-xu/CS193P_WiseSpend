//
//  EventDetailView.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/28.
//

import SwiftUI
import MapKit

struct EventDetailView: View {
    
    @Binding var event: SpendEvent
        
    @StateObject var mapData = MapViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("Date: \(event.date.printDate(showDay: true))")
                    .padding(.bottom, 2)
                Text("Spending: \(String(format: "%.1f", event.spending))")
                    .padding(.bottom, 2)
                Text("Location: " +  (event.location ?? "Unset Location"))
                    .padding(.bottom, 2)
                mapSection
            }
            .padding(.horizontal, 15)
        }
        .navigationTitle(event.name)
    }
    
    var mapSection: some View {
        ZStack(alignment: .top) {
            MapView()
                .environmentObject(mapData)
                .onAppear {
                    if event.lattitude != nil {
                        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: event.lattitude!, longitude: event.longitude!))
                        mapData.selectPlace(placemark: placemark)
                    }
                }
            
            VStack(alignment: .leading, spacing: 0) {
                TextField("Search", text: $mapData.searchTxt)
                .padding(.vertical, 5)
                .padding(.horizontal, 25)
                .background(Color(.systemGray5))
                .cornerRadius(6)
                .overlay (
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Spacer()
                    }
                    .padding(.horizontal, 5)
                    .foregroundColor(.gray)
                )
                    .padding(.top)
                    .padding(.horizontal)
                
                if !mapData.places.isEmpty && mapData.searchTxt != "" {
                    ScrollView {
                        VStack {
                            ForEach(mapData.places) { place in
                                Text(place.placemark.name ?? "")
                                    .foregroundColor(.black)
                                    .padding(.leading)
                                    .onTapGesture {
                                        mapData.selectPlace(place: place)
                                        event.lattitude = place.placemark.location?.coordinate.latitude
                                        event.longitude = place.placemark.location?.coordinate.longitude
                                        event.location = place.placemark.name
                                    }
                                Divider()
                            }
                        }
                        .padding(.top)
                    }
                    .background(Color.white)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                }
                
            }
        }
        .onChange(of: mapData.searchTxt) { value in
            let delay = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == mapData.searchTxt {
                    self.mapData.searchQuery()
                }
            }
        }
    }
}

struct Location: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

//struct EventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailView(event: preview_event)
//    }
//}
