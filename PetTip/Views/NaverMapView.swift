//
//  MapView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/30.
//

import SwiftUI
import NMapsMap
import CoreLocation

struct NaverMapView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var address: String = "주소를 불러오는 중..."

    var body: some View {
        VStack {
            NaverMap(centerCoordinate: $locationManager.currentLocation, address: $address)
                .onAppear {
                    locationManager.requestLocation()
                }
                .frame(height: 360)

            Spacer()

            Text(address)
                .padding()

            Spacer()
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.currentLocation = location.coordinate
        }
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}

struct NaverMap: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D?
    @Binding var address: String
    let naverMapView = NMFNaverMapView()

    func makeUIView(context: Context) -> NMFNaverMapView {
        initMap()
        return naverMapView
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        if let coordinate = centerCoordinate {
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
            uiView.mapView.moveCamera(cameraUpdate)
            reverseGeocode(coordinate: coordinate)
        }
    }

    func initMap() {
        naverMapView.mapView.mapType = .basic
        naverMapView.mapView.positionMode = .direction
        naverMapView.mapView.zoomLevel = 17
        naverMapView.mapView.minZoomLevel = 5.0
        // naverMapView.showLocationButton = true
    }

    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            // if let error = error {
            //     print("Reverse Geocoding Error: \(error.localizedDescription)")
            //     DispatchQueue.main.async {
            //         self.address = "주소를 불러올 수 없습니다."
            //     }
            //     return
            // }

            if let placemark = placemarks?.first {
                // let address = [placemark.country, placemark.administrativeArea, placemark.locality, placemark.name].compactMap { $0 }.joined(separator: " ")
                let address = [placemark.thoroughfare, placemark.subThoroughfare].compactMap { $0 }.joined(separator: " ")
                DispatchQueue.main.async {
                    self.address = address
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NMFMapViewCameraDelegate {
        var parent: NaverMap

        init(_ parent: NaverMap) {
            self.parent = parent
        }

        func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
            let center = mapView.cameraPosition.target
            parent.reverseGeocode(coordinate: CLLocationCoordinate2D(latitude: center.lat, longitude: center.lng))
        }
    }
}

#Preview {
    NaverMapView()
}
