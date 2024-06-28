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
        let viewController = UIStoryboard(name: "CustomerCenter", bundle: nil).instantiateViewController(identifier: "CustomerCenterViewController") as! CustomerCenterViewController
        return viewController
    }

    func updateUIViewController(_ uiViewController: CustomerCenterViewController, context: Context) {}
}

#Preview {
    CustomerView()
}
