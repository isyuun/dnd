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

    private let title: Text
    private let message: Text
    private let dismissButton: AlertButton?
    private let primaryButton: AlertButton?
    private let secondaryButton: AlertButton?
}

extension CustomAlertModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                CustomAlert(title: title, message: message, dismissButton: dismissButton, primaryButton: primaryButton, secondaryButton: secondaryButton)
                    .background(BackgroundBlurView())
            }
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension CustomAlertModifier {
    init(title: Text = Text(""), message: Text = Text(""), dismissButton: AlertButton?, primaryButton: AlertButton?, secondaryButton: AlertButton?, isPresented: Binding<Bool>) {
        self.title = title
        self.message = message

        self.dismissButton = dismissButton
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton

        _isPresented = isPresented
    }

    init(title: Text = Text(""), message: Text = Text(""), dismissButton: AlertButton, isPresented: Binding<Bool>) {
        self.title = title
        self.message = message
        self.dismissButton = dismissButton

        self.primaryButton = nil
        self.secondaryButton = nil

        _isPresented = isPresented
    }

    init(title: Text = Text(""), message: Text = Text(""), primaryButton: AlertButton, secondaryButton: AlertButton, isPresented: Binding<Bool>) {
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton

        self.dismissButton = nil

        _isPresented = isPresented
    }
}
