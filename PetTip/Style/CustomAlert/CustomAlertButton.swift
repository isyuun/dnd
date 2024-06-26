//
//  CustomAlertButton.swift
//  PetTip
//
//  Created by isyuun on 2024/6/25.
//

import SwiftUI

// struct CustomAlertButton: View {
//     // MARK: - Value
// 
//     // MARK: Public
// 
//     let title: LocalizedStringKey
//     var action: (() -> Void)? = nil
// 
//     // MARK: - View
// 
//     // MARK: Public
// 
//     var body: some View {
//         Button {
//             action?()
// 
//         } label: {
//             Text(title)
//                 // .font(.system(size: 14, weight: .medium))
//                 .foregroundColor(.white)
//                 .padding(.horizontal, 8)
//                 .padding(.vertical, 6)
//         }
//         .frame(height: 30)
//         .background(Color.purple)
//         .cornerRadius(15)
//     }
// }

struct CustomAlertButtonDemoView: View {
    var body: some View {
        AlertButton.default("AlertButton.default")
        AlertButton.cancel("AlertButton.cancel")
        AlertButton.destructive("AlertButton.destructive")
    }
}

#Preview {
    CustomAlertButtonDemoView()
}

struct AlertButton: View {
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
                .font(.system(size: 12))
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
        }
        .buttonStyle(style)
    }
}

extension AlertButton {
    static func `default`(_ title: LocalizedStringKey, action: (() -> Void)? = nil) -> AlertButton {
        AlertButton(button: .default, title: title, action: action)
    }
}

extension AlertButton {
    static func cancel(_ title: LocalizedStringKey, action: (() -> Void)? = nil) -> AlertButton {
        AlertButton(button: .cancel, title: title, action: action)
    }
}

extension AlertButton {
    static func destructive(_ title: LocalizedStringKey, action: (() -> Void)? = nil) -> AlertButton {
        AlertButton(button: .destructive, title: title, action: action)
    }
}
