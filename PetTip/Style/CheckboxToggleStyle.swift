//
//  CheckboxToggleStyle.swift
//  PetTip
//
//  Created by isyuun on 2024/6/14.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    var onToggle: ((Bool) -> Void)?

    init(onToggle: ((Bool) -> Void)? = nil) {
        self.onToggle = onToggle
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.accentColor)
                .onTapGesture {
                    configuration.isOn.toggle()
                    onToggle?(configuration.isOn)
                }
            configuration.label
                .onTapGesture {
                    configuration.isOn.toggle()
                    onToggle?(configuration.isOn)
                }
        }
    }
}
