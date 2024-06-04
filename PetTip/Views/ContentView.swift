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
    ContentView(isLogin: false)
}

struct ContentView: View {
    @State var isLogin = false
    @State var showPermissionView = false

    @State var showAlert = true
    @State var alertMessage = ""

    var body: some View {
        let isNeedLogin = !self.isLogin
        let v = if self.showPermissionView == true {
            AnyView(
                PermissionView(showPermissionView: self.$showPermissionView)
            )
        } else {
            if isNeedLogin {
                AnyView(
                    SNSLoginView(isLogin: self.$isLogin)
                )
            } else {
                AnyView(
                    NaviateTabView()
                        .navigationBarItems(
                            trailing:
                            HStack {
                                Button(action: {
                                    // 알림 버튼 눌렀을 때의 액션
                                }) {
                                    Image(systemName: "bell")
                                }
                                Button(action: {
                                    // 메뉴 버튼 눌렀을 때의 액션
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                }
                            }
                        )
                )
            }
        }
        NavigationView {
            v
            // .navigationTitle("PetTip")
            .navigationBarItems(
                leading: Image("logo")
            )
        }
        .onAppear {
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
                    showPermissionView = true
                }
                // showPermissionView = false  //test
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
            showPermissionView = true
        case .notDetermined:
            print("Location permission not determined")
            showPermissionView = true
        @unknown default:
            print("Unexpected case")
            showPermissionView = true
        }
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            print("Photo Library permission authorized")
        case .denied, .restricted:
            print("Photo Library permission not authorized")
            showPermissionView = true
        case .notDetermined:
            print("Photo Library permission not determined")
            showPermissionView = true
        case .limited:
            print("Photo Library permission limited")
            showPermissionView = true
        @unknown default:
            print("Unexpected case")
            showPermissionView = true
        }
    }
}
