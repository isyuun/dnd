//
//  MapView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/30.
//

import SwiftUI
import NMapsMap

struct NaverMapView: View {
    var body: some View {
        NaverMap()
    }
}

struct NaverMap: UIViewRepresentable {
    @State var coord: (Double, Double) = (127.065279, 37.334722)
    let naverMapView = NMFNaverMapView()
    var mapView: NMFMapView {
        return naverMapView.mapView
    }

    func makeUIView(context: Context) -> NMFNaverMapView {
        initMap()
        return naverMapView
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}

    var zoomControlView: NMFZoomControlView!
    var locationButton: NMFLocationButton!

    func initMap() {
        mapView.mapType = .basic
        // mapView.isNightModeEnabled = traitCollection.userInterfaceStyle == .dark ? true : false // default:false
        mapView.positionMode = .direction
        mapView.zoomLevel = 17
        mapView.minZoomLevel = 5.0
    }
}

#Preview {
    NaverMapView()
}
