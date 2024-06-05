//
//  MyPageView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        MyPageViewCtrl()
    }
}

struct MyPageViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MyPageViewController2 {
        return UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(identifier: "MyPageViewController") as! MyPageViewController2
    }

    func updateUIViewController(_ uiViewController: MyPageViewController2, context: Context) {
        guard let titleBarView = uiViewController.titleBarView else { return }
        titleBarView.Hide()

    }
}

#Preview {
    MyPageView()
}
