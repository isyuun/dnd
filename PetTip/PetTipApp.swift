//
//  PetTipApp.swift
//  PetTip
//
//  Created by isyuun on 2024/5/27.
//

import SwiftUI

@main
struct PetTipApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate5.self) var delegate

    @State private var isLogin = false
    @State private var isWelcomeViewActive = true

    var body: some Scene {
        WindowGroup {
            RootView(isLogin: $isLogin, isWelcomeViewActive: $isWelcomeViewActive)
                .onAppear {
                    isLogin = UserDefaults.standard.value(forKey: "accessToken") != nil
                    isWelcomeViewActive = !isLogin
                }
                // .environment(\.font, .system(size: 12))
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
