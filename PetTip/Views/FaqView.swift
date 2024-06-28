//
//  FaqView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/24.
//

import SwiftUI

struct FaqView: View {
    var body: some View {
        FaqViewCtrl()
            .navigationTitle("FAQ")
    }
}

struct FaqViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FaqViewController {
        let viewController = UIStoryboard(name: "CustomerCenter", bundle: nil).instantiateViewController(withIdentifier: "FaqViewController") as! FaqViewController
        return viewController
    }

    func updateUIViewController(_ uiViewController: FaqViewController, context: Context) {}
}

#Preview {
    FaqView()
}
