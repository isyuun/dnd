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
            Button("동의안함") {
                configuration.isOn = false
                onToggle?(configuration.isOn)
            }.buttonStyle(.secondary)
            Button("동의함") {
                configuration.isOn = true
                onToggle?(configuration.isOn)
            }.buttonStyle(.primary)
        }
        .padding()
    }
}
