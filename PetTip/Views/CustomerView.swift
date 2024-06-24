//
//  CustomerView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/24.
//

import SwiftUI

struct CustomerView: View {
    var body: some View {
        CustomerViewCtrl()
            .navigationTitle("고객센터")
    }
}

struct CustomerViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CustomerCenterViewController {
        return UIStoryboard(name: "CustomerCenter", bundle: nil).instantiateViewController(identifier: "CustomerCenterViewController") as! CustomerCenterViewController
    }

    func updateUIViewController(_ uiViewController: CustomerCenterViewController, context: Context) {
        // guard let titleBarView = uiViewController.titleBarView else { return }
        // titleBarView.Hide()
    }
}

#Preview {
    CustomerView()
}
