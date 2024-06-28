//
//  NoticeView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/24.
//

import SwiftUI

struct NoticeView: View {
    var body: some View {
        NoticeViewCtrl()
            .navigationTitle("공지사항")
    }
}

struct NoticeViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> NoticeViewController {
        let viewController = UIStoryboard(name: "CustomerCenter", bundle: nil).instantiateViewController(withIdentifier: "NoticeViewController") as! NoticeViewController
        return viewController
    }

    func updateUIViewController(_ uiViewController: NoticeViewController, context: Context) {}
}

#Preview {
    NoticeView()
}
