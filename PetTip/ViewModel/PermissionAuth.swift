//
//  PermissionAuth.swift
//  PetTip
//
//  Created by isyuun on 2024/6/4.
//

import SwiftUI
import CoreLocation
import AVFoundation
import Photos
import UserNotifications
import HealthKit

class PermissionAuth: NSObject, ObservableObject {
    @Binding var showPermissionView: Bool

    init(showPermissionView: Binding<Bool>) {
        _showPermissionView = showPermissionView
    }

    func checkNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus != .authorized {
                    print("Notification permission not authorized")
                    self.showPermissionView = true
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

    func checkPermissions() {
        checkPhotoLibraryPermission()
        checkLocationPermission()
        checkNotificationPermission()
    }
    
    @State var isNotificationPermission = false
    private func requestNotificationPermission(complete: @escaping (_ granted: Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    // Permission granted
                    self.isNotificationPermission = true
                } else {
                    // // Permission denied
                    // alertMessage = "알림 권한이 필요합니다.\n디바이스의 '설정 > 알림'에서 알림 권한을 켜주세요."
                    // showAlert = true
                }
                complete(self.isNotificationPermission)
            }
        }
    }

    private func requestNotificationPermission() {
        requestNotificationPermission { granted in }
    }

    @State var isLocationPermission = false
    private func requestLocationPermission(complete: @escaping (_ granted: Bool) -> Void) {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        let delegateWrapper = CLLocationManagerDelegateWrapper { status in
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                self.isLocationPermission = true
            case .restricted, .notDetermined:
                // 아직 결정되지 않은 상태: 요청을 다시 호출하거나 사용자가 결정할 때까지 대기
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                // // 거부됨: 사용자가 설정을 변경하도록 안내
                // self.alertMessage = "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요."
                // self.showAlert = true
                break
            @unknown default:
                break
            }
            complete(self.isLocationPermission)
        }
        locationManager.delegate = delegateWrapper

        // 메모리에서 해제되지 않도록 delegateWrapper를 유지
        objc_setAssociatedObject(locationManager, &AssociatedKeys.delegateWrapper, delegateWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    // CLLocationManagerDelegate를 클로저로 처리하기 위한 래퍼 클래스
    class CLLocationManagerDelegateWrapper: NSObject, CLLocationManagerDelegate {
        private let didChangeAuthorization: (CLAuthorizationStatus) -> Void

        init(didChangeAuthorization: @escaping (CLAuthorizationStatus) -> Void) {
            self.didChangeAuthorization = didChangeAuthorization
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            didChangeAuthorization(status)
        }
    }

    private enum AssociatedKeys {
        static var delegateWrapper = "delegateWrapper"
    }

    private func requestLocationPermission() {
        requestLocationPermission { granted in }
    }

    @State var isPhotoLibraryPermission = false
    private func requestPhotoLibraryPermission(complete: @escaping (_ granted: Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized || status == .limited {
                    // Permission granted
                    self.isPhotoLibraryPermission = true
                } else {
                    // // Permission denied
                    // alertMessage = "저장소 권한이 필요합니다.\n디바이스의 '설정 > 사진'에서 저장소 권한을 켜주세요."
                    // showAlert = true
                }
                complete(self.isPhotoLibraryPermission)
            }
        }
    }

    private func requestPhotoLibraryPermission() {
        requestPhotoLibraryPermission { granted in }
    }

    private func requestHealthPermission() {
        let healthStore = HKHealthStore()
        if HKHealthStore.isHealthDataAvailable() {
            let typesToShare: Set<HKSampleType> = [] // Specify data types to share
            let typesToRead: Set<HKSampleType> = [] // Specify data types to read
            healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
                if success {
                    // Permission granted
                    print("Health access granted")
                } else {
                    // Permission denied
                    print("Health access denied")
                }
            }
        }
    }

    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                // Permission granted
                print("Camera access granted")
            } else {
                // Permission denied
                print("Camera access denied")
            }
        }
    }
}
