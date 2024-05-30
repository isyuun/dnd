//
//  PetTipApp.swift
//  PetTip
//
//  Created by isyuun on 2024/5/27.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging
import UserNotifications
import KakaoSDKAuth
import KakaoSDKCommon
import NaverThirdPartyLogin
import DropDown

@main
struct PetTipApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate2

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
