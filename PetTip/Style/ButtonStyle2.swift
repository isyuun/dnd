//
//  ButtonStyle2.swift
//  PetTip
//
//  Created by isyuun on 2024/6/19.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        // let colorScheme = Environment(\.colorScheme).wrappedValue
        // let textColor = colorScheme == .dark ? Color.secondary : Color.primary
        // let backColor = colorScheme == .dark ? Color.primary : Color.secondary

        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray, lineWidth: 0.5)
            )
            .overlay(
                Color.accentColor
                    .opacity(configuration.isPressed ? 0.5 : 0)
            )
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self { return .init() }
}

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        // let colorScheme = Environment(\.colorScheme).wrappedValue
        // let textColor = colorScheme == .dark ? Color.secondary : Color.primary
        // let backColor = colorScheme == .dark ? Color.primary : Color.secondary

        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray, lineWidth: 0.5)
            )
            .overlay(
                Color.secondary
                    .opacity(configuration.isPressed ? 0.5 : 0)
            )
    }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: Self { return .init() }
}

public struct TertiaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        // let colorScheme = Environment(\.colorScheme).wrappedValue
        // let textColor = colorScheme == .dark ? Color.secondary : Color.primary
        // let backColor = colorScheme == .dark ? Color.primary : Color.secondary

        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.secondary)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray, lineWidth: 0.5)
            )
            .overlay(
                Color.secondary
                    .opacity(configuration.isPressed ? 0.5 : 0)
            )
    }
}

public extension ButtonStyle where Self == TertiaryButtonStyle {
    static var tertiary: Self { return .init() }
}

public struct PrimarySmallButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        // let colorScheme = Environment(\.colorScheme).wrappedValue
        // let textColor = colorScheme == .dark ? Color.secondary : Color.primary
        // let backColor = colorScheme == .dark ? Color.primary : Color.secondary

        configuration.label
            .foregroundColor(.white)
            .padding(5)
            // .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray, lineWidth: 0.5)
            )
            .overlay(
                Color.accentColor
                    .opacity(configuration.isPressed ? 0.5 : 0)
            )
    }
}

public extension ButtonStyle where Self == PrimarySmallButtonStyle {
    static var primarySmall: Self { return .init() }
}

public struct SecondarySmallButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        // let colorScheme = Environment(\.colorScheme).wrappedValue
        // let textColor = colorScheme == .dark ? Color.secondary : Color.primary
        // let backColor = colorScheme == .dark ? Color.primary : Color.secondary

        configuration.label
            .foregroundColor(.white)
            .padding(5)
            // .frame(maxWidth: .infinity)
            .background(Color.red)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray, lineWidth: 0.5)
            )
            .overlay(
                Color.secondary
                    .opacity(configuration.isPressed ? 0.5 : 0)
            )
    }
}

public extension ButtonStyle where Self == SecondarySmallButtonStyle {
    static var secondarySmall: Self { return .init() }
}

public struct TertiarySmallButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        // let colorScheme = Environment(\.colorScheme).wrappedValue
        // let textColor = colorScheme == .dark ? Color.secondary : Color.primary
        // let backColor = colorScheme == .dark ? Color.primary : Color.secondary

        configuration.label
            .foregroundColor(.white)
            .padding(5)
            // .frame(maxWidth: .infinity)
            .background(Color.secondary)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray, lineWidth: 0.5)
            )
            .overlay(
                Color.secondary
                    .opacity(configuration.isPressed ? 0.5 : 0)
            )
    }
}

public extension ButtonStyle where Self == TertiarySmallButtonStyle {
    static var tertiarySmall: Self { return .init() }
}
