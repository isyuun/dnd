//
//  WalkMapView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

struct WalkMapView: View {
    var body: some View {
        VStack {
            WalkMapViewCtrl()
                .navigationTitle("산책하기")
        }
    }
}

struct WalkMapViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> NMapViewController5 {
        return UIStoryboard(name: "Map", bundle: nil).instantiateViewController(identifier: "NMapViewController") as! NMapViewController5
    }

    func updateUIViewController(_ uiViewController: NMapViewController5, context: Context) {
        uiViewController.hideBackTitleBarView()
    }
}

#Preview {
    WalkMapView()
}
