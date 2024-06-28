//
//  CustomAlertButton.swift
//  PetTip
//
//  Created by isyuun on 2024/6/25.
//

import SwiftUI

struct CustomAlertButtonDemoView: View {
    var body: some View {
        CustomAlertButton.default("AlertButton.default")
        CustomAlertButton.cancel("AlertButton.cancel")
        CustomAlertButton.destructive("AlertButton.destructive")
    }
}

#Preview {
    CustomAlertButtonDemoView()
}

struct CustomAlertButton: View {
    // MARK: - Value

    enum ButtonType {
        case `default`
        case cancel
        case destructive
    }

    let button: ButtonType

    // MARK: Public

    let title: LocalizedStringKey
    var action: (() -> Void)? = nil

    // MARK: - View

    // MARK: Public

    var body: some View {
        var style: AnyButtonStyle

        switch button {
        case .cancel:
            style = AnyButtonStyle(SecondarySmallButtonStyle())
        case .destructive:
            style = AnyButtonStyle(TertiarySmallButtonStyle())
        default:
            style = AnyButtonStyle(PrimarySmallButtonStyle())
        }

        return Button(action: {
            action?()
        }) {
            Text(title)
                .font(.system(size: .caption))
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
        }
        .buttonStyle(style)
    }
}

extension CustomAlertButton {
    static func `default`(_ title: LocalizedStringKey, action: (() -> Void)? = nil) -> CustomAlertButton {
        CustomAlertButton(button: .default, title: title, action: action)
    }
}

extension CustomAlertButton {
    static func cancel(_ title: LocalizedStringKey, action: (() -> Void)? = nil) -> CustomAlertButton {
        CustomAlertButton(button: .cancel, title: title, action: action)
    }
}

extension CustomAlertButton {
    static func destructive(_ title: LocalizedStringKey, action: (() -> Void)? = nil) -> CustomAlertButton {
        CustomAlertButton(button: .destructive, title: title, action: action)
    }
}
