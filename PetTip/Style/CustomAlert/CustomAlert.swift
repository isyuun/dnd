//
//  CustomAlert.swift
//  PetTip
//
//  Created by isyuun on 2024/6/25.
//

import SwiftUI

struct CustomAlert: View {
    // MARK: - Value

    // MARK: Public

    let title: Text
    let message: Text
    let dismissButton: CustomAlertButton?
    let primaryButton: CustomAlertButton?
    let secondaryButton: CustomAlertButton?

    init(title: Text, message: Text, dismissButton: CustomAlertButton? = nil, primaryButton: CustomAlertButton? = nil, secondaryButton: CustomAlertButton? = nil) {
        self.title = title
        self.message = message

        self.dismissButton = dismissButton
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }

    /// Creates an alert with one button.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message to display in the body of the alert.
    ///   - dismissButton: The button that dismisses the alert.
    init(title: Text, message: Text, dismissButton: CustomAlertButton? = nil) {
        self.title = title
        self.message = message

        self.dismissButton = dismissButton
        self.primaryButton = nil
        self.secondaryButton = nil
    }

    /// Creates an alert with two buttons.
    ///
    /// The system determines the visual ordering of the buttons.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message to display in the body of the alert.
    ///   - primaryButton: The first button to show in the alert.
    ///   - secondaryButton: The second button to show in the alert.
    init(title: Text, message: Text, primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton) {
        self.title = title
        self.message = message

        self.dismissButton = nil
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }

    // MARK: Private

    @State private var opacity: CGFloat = 0
    @State private var backgroundOpacity: CGFloat = 0
    @State private var scale: CGFloat = 0.001

    @Environment(\.dismiss) private var dismiss

    // MARK: - View

    // MARK: Public

    var body: some View {
        ZStack {
            dimView

            alertView
                .scaleEffect(scale)
                .opacity(opacity)
        }
        .ignoresSafeArea()
        .transition(.opacity)
        .task {
            animate(isShown: true)
        }
        .background(.clear)
        .onTapGesture {
            animate(isShown: false) {
                dismiss()
            }
        }
    }

    // MARK: Private

    private var alertView: some View {
        VStack(spacing: 10) {
            titleView
                .padding(.bottom, 10)
            messageView
            buttonsView
        }
        .padding(20)
        .frame(width: 320)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.4), radius: 16, x: 0, y: 12)
    }

    @ViewBuilder
    private var titleView: some View {
        title
            .font(.system(size: .callout, weight: .bold))
            // .foregroundColor(.black)
            .lineSpacing(24 - UIFont.systemFont(ofSize: 18, weight: .bold).lineHeight)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var messageView: some View {
        message
            .font(.system(size: .default))
            .foregroundColor(.gray)
            .lineSpacing(24 - UIFont.systemFont(ofSize: 16).lineHeight)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var buttonsView: some View {
        HStack(spacing: 12) {
            Spacer()
            if dismissButton != nil {
                dismissButtonView

            } else if primaryButton != nil, secondaryButton != nil {
                secondaryButtonView
                primaryButtonView
            }
        }
        .padding(.top, 23)
    }

    @ViewBuilder
    private var primaryButtonView: some View {
        if let button = primaryButton {
            CustomAlertButton(button: button.button, title: button.title) {
                animate(isShown: false) {
                    dismiss()
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    button.action?()
                }
            }
        }
    }

    @ViewBuilder
    private var secondaryButtonView: some View {
        if let button = secondaryButton {
            CustomAlertButton(button: button.button, title: button.title) {
                animate(isShown: false) {
                    dismiss()
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    button.action?()
                }
            }
        }
    }

    @ViewBuilder
    private var dismissButtonView: some View {
        if let button = dismissButton {
            CustomAlertButton(button: button.button, title: button.title) {
                animate(isShown: false) {
                    dismiss()
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    button.action?()
                }
            }
        }
    }

    private var dimView: some View {
        Color.gray
            .opacity(0.3)
            .opacity(backgroundOpacity)
    }

    // MARK: - Function

    // MARK: Private

    private func animate(isShown: Bool, completion: (() -> Void)? = nil) {
        switch isShown {
        case true:
            opacity = 1

            withAnimation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0).delay(0.5)) {
                backgroundOpacity = 1
                scale = 1
            }
            // withAnimation(.easeOut(duration: 0.2)) {
            //     backgroundOpacity = 1
            //     scale = 1
            // }


            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion?()
            }

        case false:
            withAnimation(.easeOut(duration: 0.2)) {
                backgroundOpacity = 0
                opacity = 0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion?()
            }
        }
    }
}

#if DEBUG
struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        let dismissButton = CustomAlertButton.destructive("OK")
        let primaryButton = CustomAlertButton.default("OK")
        let secondaryButton = CustomAlertButton.cancel("Cancel")

        let title = "This is your life. Do what you want and do it often."
        let message = """
        If you don't like something, change it.
        If you don't like your job, quit.
        If you don't have enough time, stop watching TV.
        """

        return VStack {
            CustomAlert(title: Text(title), message: Text(message), dismissButton: nil, primaryButton: nil, secondaryButton: nil)
            CustomAlert(title: Text(title), message: Text(message), dismissButton: dismissButton, primaryButton: nil, secondaryButton: nil)
            CustomAlert(title: Text(title), message: Text(message), dismissButton: nil, primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
    }
}
#endif
