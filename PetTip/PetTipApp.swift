//
//  PetTipApp.swift
//  PetTip
//
//  Created by isyuun on 2024/5/27.
//

import SwiftUI

@main
struct PetTipApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate2

    @State private var isLogin = false
    @State private var isWelcomeViewActive = true

    var body: some Scene {
        WindowGroup {
            RootView(isLogin: $isLogin, isWelcomeViewActive: $isWelcomeViewActive)
                .onAppear {
                    isWelcomeViewActive = false
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
