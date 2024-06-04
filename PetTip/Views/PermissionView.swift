//
//  PermissionView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/3.
//

#Preview {
    PermissionView(showPermissionView: .constant(false))
}

import SwiftUI
import CoreLocation
import AVFoundation
import Photos
import UserNotifications
import HealthKit

struct PermissionView: View {
    @Binding var showPermissionView: Bool
    @State var showAlert = false
    @State var alertMessage = ""

    // 필수 항목에 대한 배열 선언
    private var requiredPermissions: [(image: String, title: String, description: String, action: () -> Void)] = []

    init(showPermissionView: Binding<Bool>) {
        _showPermissionView = showPermissionView
        // 필수 항목을 배열에 추가
        requiredPermissions.append((image: "bell.fill", title: "[필수] 알림", description: "이벤트, 공지 등 알림수신 사용", action: requestNotificationPermission))
        requiredPermissions.append((image: "location.fill", title: "[필수] 위치", description: "산책,우리동네맞춤지도,\n직거래 약속장소 이용", action: requestLocationPermission))
        requiredPermissions.append((image: "photo.fill", title: "[필수] 저장소", description: "프로필, 산책기록,\n상품, 팁톡 이미지 등록", action: requestPhotoLibraryPermission))
    }

    var body: some View {
        VStack {
            Text("펫팁을 이용하려면\n권한 허용이 필요해요")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading, 24)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(requiredPermissions, id: \.title) { permission in
                        PermissionItemView(image: permission.image, title: permission.title, description: permission.description) {
                            permission.action()
                        }
                    }
                    PermissionItemView(image: "figure.walk", title: "[선택] 신체활동", description: "산책서비스 건강기록 사용") {
                        requestHealthPermission()
                    }

                    PermissionItemView(image: "camera.fill", title: "[선택] 카메라", description: "프로필 이미지, 산책기록 촬영") {
                        requestCameraPermission()
                    }
                }
                .padding()
                .padding(.leading, 20) // Add left padding to VStack inside ScrollView
                .padding(.trailing, 20) // Add right padding to VStack inside ScrollView
            }

            Spacer()

            Button(action: {
                requestRequiredPermissions()
            }) {
                Text("시작하기")
                    // .font(.title2)
                    // .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("권한 필요"),
                message: Text(alertMessage),
                primaryButton: .default(Text("설정으로 이동")) {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .onAppear {
            showPermissionView = !(isLocationPermission && isPhotoLibraryPermission)
        }
        .onSubmit {
            showPermissionView = !(isLocationPermission && isPhotoLibraryPermission)
        }
    }

    @State var isNotificationPermission = false
    private func requestNotificationPermission(complete: @escaping (_ granted: Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    // Permission granted
                    self.isNotificationPermission = true
                } else {
                    // Permission denied
                    alertMessage = "알림 권한이 필요합니다.\n디바이스의 '설정 > 알림'에서 알림 권한을 켜주세요."
                    showAlert = true
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
        let delegateWrapper = CLLocationManagerDelegateWrapper { status in
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                self.isLocationPermission = true
            case .restricted, .notDetermined:
                // 아직 결정되지 않은 상태: 요청을 다시 호출하거나 사용자가 결정할 때까지 대기
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                // 거부됨: 사용자가 설정을 변경하도록 안내
                self.alertMessage = "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요."
                self.showAlert = true
            @unknown default:
                break
            }
            complete(self.isLocationPermission)
        }
        locationManager.delegate = delegateWrapper
        locationManager.requestWhenInUseAuthorization()

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
                    // Permission denied
                    alertMessage = "저장소 권한이 필요합니다.\n디바이스의 '설정 > 사진'에서 저장소 권한을 켜주세요."
                    showAlert = true
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

    private func requestRequiredPermissions() {
        // for permission in requiredPermissions {
        //     permission.action()
        // }
        requestNotificationPermission { granted in
            requestLocationPermission { granted in
                requestPhotoLibraryPermission { granted in
                    showPermissionView = !(isLocationPermission && isPhotoLibraryPermission)
                }
            }
        }
    }
}

struct PermissionItemView: View {
    var image: String
    var title: String
    var description: String
    var action: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: image)
                .resizable()
                .frame(width: 46, height: 48)
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .onTapGesture {
            action()
        }
    }
}
