//
//  WalkView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/4.
//

import SwiftUI

struct WalkView: View {
    var body: some View {
        WalkViewCtrl()
    }
}

struct WalkViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController4 {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as! MainViewController4
    }

    func updateUIViewController(_ uiViewController: MainViewController4, context: Context) {
        guard let titleBarView = uiViewController.titleBarView else { return }
        titleBarView.Hide()
    }
}

#Preview {
    WalkView()
}
