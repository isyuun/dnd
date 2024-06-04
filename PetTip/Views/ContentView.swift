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
    ContentView(isLogin: true)
}

struct ContentView: View {
    @State var isLogin = false
    @State private var showPermissionView = false

    @State var showAlert = true
    @State var alertMessage = ""

    var body: some View {
        let isNeedLogin = !isLogin
        let v = if showPermissionView == true {
            AnyView(PermissionView(showPermissionView: $showPermissionView))
        } else {
            if !isNeedLogin {
                AnyView(NaviateTabView(showPermissionView: $showPermissionView))
            } else {
                AnyView(SNSLoginView(isLogin: $isLogin))
            }
        }
        NavigationView {
            v
            // .navigationTitle(Text("PetTip"))
        }
        .onAppear {
            checkPermissions()
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
        // showPermissionView = false   //test
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
        // showPermissionView = false   //test
    }
}

struct NaviateTabView: View {
    @State private var selection = 0
    @Binding var showPermissionView: Bool

    var body: some View {
        TabView(selection: $selection) {
            WalkListView()
                .tabItem {
                    Image(systemName: "pawprint")
                    Text("산책")
                }
                .navigationTitle(Text("PetTip"))
                .tag(1)

            StoryListView()
                .tabItem {
                    Image(systemName: "message")
                    Text("팁톡")
                }
                .tag(2)

            MainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
                .tag(0)

            MallView()
                .tabItem {
                    Image(systemName: "carrot")
                    Text("팁몰")
                }
                .tag(4)

            MyPageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("My")
                }
                .tag(3)
        }
        // .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        // .tabViewStyle(PageTabViewStyle())
    }
}

struct HomeView: View {
    var body: some View {
        Text("홈")
            .font(.largeTitle)
    }
}

struct SearchView: View {
    var body: some View {
        Text("검색")
            .font(.largeTitle)
    }
}

struct TipTalkView: View {
    var body: some View {
        Text("팁톡")
            .font(.largeTitle)
    }
}

struct Profile: View {
    var body: some View {
        Text("마이")
            .font(.largeTitle)
    }
}

struct MallView: View {
    var body: some View {
        Text("팁몰")
            .font(.largeTitle)
    }
}
