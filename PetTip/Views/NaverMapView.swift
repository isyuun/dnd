//
//  MapView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/30.
//

import SwiftUI
import MapKit

struct NaverMapView: View {
    var body: some View {
        // @State var region = MKCoordinateRegion(center: .init(latitude: 37.334722, longitude: -122.008889), latitudinalMeters: 300, longitudinalMeters: 300)
        @State var region = MKCoordinateRegion(center: .init(latitude: 37.546768, longitude: 127.065279), latitudinalMeters: 300, longitudinalMeters: 300)

        Map(coordinateRegion: $region,
            interactionModes: [],
            showsUserLocation: true,
            userTrackingMode: nil,
            annotationItems: [PinItem(coordinate: .init(latitude: 37.334722, longitude: -122.008889))]) { item in
            MapMarker(coordinate: item.coordinate)
        }
    }
}

#Preview {
    NaverMapView()
}
