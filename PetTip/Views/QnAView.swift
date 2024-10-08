//
//  QnAView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/24.
//

import SwiftUI

struct QnAView: View {
    var body: some View {
        QnAViewCtrl()
            .navigationTitle("1:1문의")
    }
}

struct QnAViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> QnAViewController {
        let viewController = UIStoryboard(name: "CustomerCenter", bundle: nil).instantiateViewController(withIdentifier: "QnAViewController") as! QnAViewController
        return viewController
    }

    func updateUIViewController(_ uiViewController: QnAViewController, context: Context) {}
}

#Preview {
    QnAView()
}
