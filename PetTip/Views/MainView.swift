//
//  MainView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

struct MainView: View {
    @Binding var isLogin: Bool

    var body: some View {
        MainViewCtrl(isLogin: $isLogin)
    }
}

struct MainViewCtrl: UIViewControllerRepresentable {
    @Binding var isLogin: Bool

    func makeUIViewController(context: Context) -> MainViewController5 {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as! MainViewController5
        viewController.onMoveLoginPage = {
            self.isLogin = false
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: MainViewController5, context: Context) {
        guard let titleBarView = uiViewController.titleBarView else { return }
        titleBarView.Hide()
    }
}

#Preview {
    MainView(isLogin: .constant(true))
}
