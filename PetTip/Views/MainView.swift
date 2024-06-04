//
//  MainView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        MainViewCtrl()
    }
}

struct MainViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController4 {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as! MainViewController4
    }

    func updateUIViewController(_ uiViewController: MainViewController4, context: Context) {
        guard let titleBarView = uiViewController.titleBarView else { return }
        titleBarView.isHidden = true
        if let heightConstraint = titleBarView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = 0
            titleBarView.layoutIfNeeded()
        }
    }
}

#Preview {
    MainView()
}
