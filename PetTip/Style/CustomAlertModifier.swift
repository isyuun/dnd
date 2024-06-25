//
//  CustomAlertModifier.swift
//  PetTip
//
//  Created by isyuun on 2024/6/25.
//

import SwiftUI

struct CustomAlertModifier {
    // MARK: - Value

    // MARK: Private

    @Binding private var isPresented: Bool

    // MARK: Private

    private let title: String
    private let message: String
    private let dismissButton: DismissButton?
    private let primaryButton: PrimaryButton?
    private let secondaryButton: SecondaryButton?
}

extension CustomAlertModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                CustomAlert(title: title, message: message, dismissButton: dismissButton, primaryButton: primaryButton, secondaryButton: secondaryButton)
            }
    }
}

extension CustomAlertModifier {
    init(title: String = "", message: String = "", dismissButton: DismissButton, isPresented: Binding<Bool>) {
        self.title = title
        self.message = message
        self.dismissButton = dismissButton

        self.primaryButton = nil
        self.secondaryButton = nil

        _isPresented = isPresented
    }

    init(title: String = "", message: String = "", primaryButton: PrimaryButton, secondaryButton: SecondaryButton, isPresented: Binding<Bool>) {
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton

        self.dismissButton = nil

        _isPresented = isPresented
    }
}
