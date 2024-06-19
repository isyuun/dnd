//
//  ButtonToggleStyle.swift
//  PetTip
//
//  Created by isyuun on 2024/6/17.
//

import SwiftUI

struct ButtonToggleStyle: ToggleStyle {
    var onToggle: ((Bool) -> Void)?

    init(onToggle: ((Bool) -> Void)? = nil) {
        self.onToggle = onToggle
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            // Button(action: {
            //     configuration.isOn = false
            //     onToggle?(configuration.isOn)
            // }) {
            //     Text("동의안함")
            //         .foregroundColor(.white)
            //         .padding()
            //         .frame(maxWidth: .infinity)
            //         .background(Color.secondary)
            //         .cornerRadius(5)
            // }
            Button("동의안함") {
                configuration.isOn = false
                onToggle?(configuration.isOn)
            }.buttonStyle(.secondaryButton)
            // Button(action: {
            //     configuration.isOn = true
            //     onToggle?(configuration.isOn)
            // }) {
            //     Text("동의함")
            //         .foregroundColor(.white)
            //         .padding()
            //         .frame(maxWidth: .infinity)
            //         .background(Color.accentColor)
            //         .cornerRadius(5)
            // }
            Button("동의함") {
                configuration.isOn = true
                onToggle?(configuration.isOn)
            }.buttonStyle(.primaryButton)
        }
        .padding()
    }
}
