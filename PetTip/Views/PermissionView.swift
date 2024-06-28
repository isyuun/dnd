//
//  PermissionView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/27.
//

import SwiftUI

struct PermissionView: View {
    @Binding var showPermissionView: Bool

    var body: some View {
        PermissionViewCtrl()
    }
}

struct PermissionViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PermissionInfoViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PermissionInfoViewController") as! PermissionInfoViewController
        return viewController
    }

    func updateUIViewController(_ uiViewController: PermissionInfoViewController, context: Context) {}
}

#Preview {
    PermissionView(showPermissionView: .constant(true))
}
