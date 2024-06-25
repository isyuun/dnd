//
//  MyPageView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

struct MyPageView: View {
    @Binding var isLogin: Bool

    var body: some View {
        MyPageViewCtrl(isLogin: $isLogin)
    }
}

struct MyPageViewCtrl: UIViewControllerRepresentable {
    @Binding var isLogin: Bool

    func makeUIViewController(context: Context) -> MyPageViewController2 {
        let viewController = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(identifier: "MyPageViewController") as! MyPageViewController2
        viewController.onMoveLoginPage = {
            self.isLogin = false
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: MyPageViewController2, context: Context) {
        uiViewController.lb_title?.superview?.Hide()
    }
}

#Preview {
    MyPageView(isLogin: .constant(true))
}
