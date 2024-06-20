//
//  ContentView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/27.
//

import SwiftUI
import CoreLocation
import AVFoundation
import Photos
import UserNotifications
import HealthKit

#Preview {
    // ContentView(isLogin: true, isPermissionViewShow: false, isWelcomeViewActive: true)
    ContentView()
}

struct ContentView: View {
    @State private var isLogin = false
    @State private var isPermissionViewShow = false

    @State private var showAlert = true
    @State private var alertMessage = ""

    var body: some View {
        let isNeedLogin = !isLogin
        let v = if isPermissionViewShow {
            AnyView(PermissionView(showPermissionView: $isPermissionViewShow))
        } else {
            if isNeedLogin {
                AnyView(LonginView2(isLogin: $isLogin))
            } else {
                AnyView(NavigateTabView(isLogin: $isLogin))
            }
        }
        NavigationView {
            v
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        // Text("PetTip")
                        //     .foregroundColor(.red)
                        //     .font(.title) // 텍스트 크기 조정
                        //     .bold() // 필요에 따라 스타일
                        Image("logo")
                            .renderingMode(.template)
                            .foregroundColor(.red)
                    }
                }
        }
        .onAppear {
            isLogin = UserDefaults.standard.value(forKey: "accessToken") != nil
            self.checkPermissions()
        }
    }

    private func checkPermissions() {
        checkPhotoLibraryPermission()
        checkLocationPermission()
        checkNotificationPermission()
    }

    func checkNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus != .authorized {
                    print("Notification permission not authorized")
                    isPermissionViewShow = true
                }
                // isPermissionViewShow = false  //test
            }
        }
    }

    func checkLocationPermission() {
        let locationManager = CLLocationManager()
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location permission authorized")
        case .denied, .restricted:
            print("Location permission not authorized")
            isPermissionViewShow = true
        case .notDetermined:
            print("Location permission not determined")
            isPermissionViewShow = true
        @unknown default:
            print("Unexpected case")
            isPermissionViewShow = true
        }
    }

    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            print("Photo Library permission authorized")
        case .denied, .restricted:
            print("Photo Library permission not authorized")
            isPermissionViewShow = true
        case .notDetermined:
            print("Photo Library permission not determined")
            isPermissionViewShow = true
        case .limited:
            print("Photo Library permission limited")
            isPermissionViewShow = true
        @unknown default:
            print("Unexpected case")
            isPermissionViewShow = true
        }
    }
}
