//
//  WalkMapView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

struct WalkMapView: View {
    var body: some View {
        WalkMap()
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
    }
}

struct WalkMap: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> NMapViewController4 {
        return UIStoryboard(name: "Map", bundle: nil).instantiateViewController(identifier: "NMapViewController") as! NMapViewController4
    }

    func updateUIViewController(_ uiViewController: NMapViewController4, context: Context) {}
}

#Preview {
    WalkMapView()
}
