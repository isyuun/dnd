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
    ContentView(isLogin: true, showPermissionView: false)
    // ContentView()
}

struct ContentView: View {
    @State var isLogin = false
    @State var showPermissionView = false

    @State var showAlert = true
    @State var alertMessage = ""

    var body: some View {
        let isNeedLogin = !isLogin
        let v = if showPermissionView == true {
            AnyView(PermissionView(showPermissionView: $showPermissionView))
        } else {
            if isNeedLogin {
                AnyView(SNSLoginView(isLogin: $isLogin))
            } else {
                AnyView(
                    NavigateTabView()
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                HStack {
                                    Button(action: {
                                        // 알림 버튼 눌렀을 때의 액션
                                    }) {
                                        Image(systemName: "bell.fill")
                                    }
                                    Button(action: {
                                        // 메뉴 버튼 눌렀을 때의 액션
                                    }) {
                                        Image(systemName: "line.horizontal.3")
                                    }
                                }
                            }
                        }
                )
            }
        }
        NavigationView {
            v
                .navigationBarTitleDisplayMode(.inline)
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
