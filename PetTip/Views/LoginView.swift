//
//  LoginView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/4.
//

import SwiftUI

#Preview {
    LoginView(isLogin: .constant(false))
}

struct LoginView: View {
    @Binding var isLogin: Bool

    var body: some View {
        LoginViewCtrl()
    }
}

struct LoginViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LoginViewController3 {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController") as! LoginViewController3
        return viewController
    }

    func updateUIViewController(_ uiViewController: LoginViewController3, context: Context) {}
}
