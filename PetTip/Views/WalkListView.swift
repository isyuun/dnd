//
//  WalkListView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

struct WalkListView: View {
    var body: some View {
        WalkListViewCtrl()
    }
}

struct WalkListViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> WalkHistoryViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WalkHistoryViewController") as! WalkHistoryViewController
    }

    func updateUIViewController(_ uiViewController: WalkHistoryViewController, context: Context) {}
}

#Preview {
    WalkListView()
}
