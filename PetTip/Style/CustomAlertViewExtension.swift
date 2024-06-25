//
//  CustomAlertViewExtension.swift
//  PetTip
//
//  Created by isyuun on 2024/6/25.
//

import SwiftUI

import SwiftUI

extension View {
    func alert(title: String = "", message: String = "", dismissButton: DismissButton = DismissButton(title: "확인"), isPresented: Binding<Bool>) -> some View {
        let title = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")

        return modifier(CustomAlertModifier(title: title, message: message, dismissButton: dismissButton, isPresented: isPresented))
    }

    func alert(title: String = "", message: String = "", primaryButton: PrimaryButton, secondaryButton: SecondaryButton, isPresented: Binding<Bool>) -> some View {
        let title = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")

        return modifier(CustomAlertModifier(title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton, isPresented: isPresented))
    }
}

struct DemoView: View {
    // MARK: - Value

    // MARK: Private

    @State private var isAlertPresented = false

    // MARK: - View

    // MARK: Public

    var body: some View {
        VStack {
            Button {
                isAlertPresented = true

            } label: {
                Text("Alert test")
            }
            Spacer()
        }
        .alert(
            title: "타이틀",
            message: "메시지",
            primaryButton: PrimaryButton(title: "네", action: {}),
            secondaryButton: SecondaryButton(title: "아니요", action: {}),
            isPresented: $isAlertPresented)
        .alert(
            title: "타이틀",
            message: "메시지",
            dismissButton: DismissButton(title: "확인", action: {}),
            isPresented: $isAlertPresented)
    }
}

#Preview {
    DemoView()
}
