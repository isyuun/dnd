//
//  CustomAlertViewExtension.swift
//  PetTip
//
//  Created by isyuun on 2024/6/25.
//

import SwiftUI

import SwiftUI

extension View {
    func alert(title: Text = Text(""), message: Text = Text(""), dismissButton: CustomAlertButton = .default("확인"), isPresented: Binding<Bool>) -> some View {
        // let title = NSLocalizedString(title, comment: "")
        // let message = NSLocalizedString(message, comment: "")

        return modifier(CustomAlertModifier(title: title, message: message, dismissButton: dismissButton, isPresented: isPresented))
    }

    func alert(title: Text = Text(""), message: Text = Text(""), primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton, isPresented: Binding<Bool>) -> some View {
        // let title = NSLocalizedString(title, comment: "")
        // let message = NSLocalizedString(message, comment: "")

        return modifier(CustomAlertModifier(title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton, isPresented: isPresented))
    }

    func alert(isPresented: Binding<Bool>, content: () -> CustomAlert) -> some View {
        let customAlert = content()
        let title: Text = customAlert.title
        let message: Text = customAlert.message
        let dismissButton: CustomAlertButton? = customAlert.dismissButton
        let primaryButton: CustomAlertButton? = customAlert.primaryButton
        let secondaryButton: CustomAlertButton? = customAlert.secondaryButton

        return modifier(CustomAlertModifier(
            title: title,
            message: message,
            dismissButton: dismissButton,
            primaryButton: primaryButton,
            secondaryButton: secondaryButton,
            isPresented: isPresented))
    }
}

struct CustomAlertDemoView: View {
    // MARK: - Value

    // MARK: Private

    @State private var showAlert = false

    // MARK: - View

    // MARK: Public

    var body: some View {
        VStack {
            Button {
                showAlert = true

            } label: {
                Text("Alert test")
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .background(.red)
        // .alert(isPresented: $showAlert) {
        //     NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)]")
        //     return CustomAlert(
        //         title: Text("알림"),
        //         message: Text("메시지"),
        //         primaryButton: .default("네") {},
        //         secondaryButton: .cancel("아니요") {})
        // }
        // .alert(isPresented: $showAlert) {
        //     NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)]")
        //     return CustomAlert(
        //         title: Text("알림"),
        //         message: Text("메시지"),
        //         dismissButton: .destructive("확인") {})
        // }
        // .alert(
        //     title: Text("타이틀"),
        //     message: Text("메시지"),
        //     primaryButton: .default("네") {},
        //     secondaryButton: .cancel("아니요") {},
        //     isPresented: $showAlert)
        .alert(
            title: Text("타이틀"),
            message: Text("메시지"),
            dismissButton: .destructive("확인") {},
            isPresented: $showAlert)
    }
}

#Preview {
    CustomAlertDemoView()
}
