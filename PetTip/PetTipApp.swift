//
//  PetTipApp.swift
//  PetTip
//
//  Created by isyuun on 2024/5/27.
//

import SwiftUI

@main
struct PetTipApp: App {
    // @UIApplicationDelegateAdaptor var appDelegate: AppDelegate4
    @UIApplicationDelegateAdaptor(AppDelegate4.self) var appDelegate

    @State private var isLogin = false
    @State private var isWelcomeViewActive = true

    // init() {
    //     NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)][\(String(describing: UIApplication.shared.delegate as? AppDelegate4))]")
    //     UIApplication.shared.delegate = appDelegate
    //     NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)][\(String(describing: UIApplication.shared.delegate as? AppDelegate4))]")
    // }

    var body: some Scene {
        WindowGroup {
            RootView(isLogin: $isLogin, isWelcomeViewActive: $isWelcomeViewActive)
                .onAppear {
                    isLogin = UserDefaults.standard.value(forKey: "accessToken") != nil
                    isWelcomeViewActive = !isLogin
                }
        }
    }
}

struct RootView: View {
    @Binding var isLogin: Bool
    @Binding var isWelcomeViewActive: Bool

    var body: some View {
        if isWelcomeViewActive {
            WelcomeView(isLogin: $isLogin, isWelcomeViewActive: $isWelcomeViewActive)
        } else {
            ContentView()
        }
    }
}
