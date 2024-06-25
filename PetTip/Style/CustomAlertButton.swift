//
//  CustomAlertButton.swift
//  PetTip
//
//  Created by isyuun on 2024/6/25.
//

import SwiftUI

struct CustomAlertButton: View {
    // MARK: - Value

    // MARK: Public

    let title: LocalizedStringKey
    var action: (() -> Void)? = nil

    // MARK: - View

    // MARK: Public

    var body: some View {
        Button {
            action?()

        } label: {
            Text(title)
                // .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 10)
        }
        .frame(height: 30)
        .background(Color.purple)
        .cornerRadius(15)
    }
}

struct PrimaryButton: View {
    // MARK: - Value

    // MARK: Public

    let title: LocalizedStringKey
    var action: (() -> Void)? = nil

    // MARK: - View

    // MARK: Public

    var body: some View {
        Button {
            action?()

        } label: {
            Text(title)
                .padding(.horizontal, 10)
        }
        .buttonStyle(.primarySmall)
    }
}

struct SecondaryButton: View {
    // MARK: - Value

    // MARK: Public

    let title: LocalizedStringKey
    var action: (() -> Void)? = nil

    // MARK: - View

    // MARK: Public

    var body: some View {
        Button {
            action?()

        } label: {
            Text(title)
                .padding(.horizontal, 10)
        }
        .buttonStyle(.secondarySmall)
    }
}

struct TertiaryButton: View {
    // MARK: - Value

    // MARK: Public

    let title: LocalizedStringKey
    var action: (() -> Void)? = nil

    // MARK: - View

    // MARK: Public

    var body: some View {
        Button {
            action?()

        } label: {
            Text(title)
                .padding(.horizontal, 10)
        }
        .buttonStyle(.tertiarySmall)
    }
}

struct DismissButton: View {
    // MARK: - Value

    // MARK: Public

    let title: LocalizedStringKey
    var action: (() -> Void)? = nil

    // MARK: - View

    // MARK: Public

    var body: some View {
        Button {
            action?()

        } label: {
            Text(title)
                .padding(.horizontal, 10)
        }
        .buttonStyle(.tertiarySmall)
    }
}
