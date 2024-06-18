//
//  TermsCheckboxView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/14.
//

import SwiftUI

struct CheckBoxTextButton: View {
    @Binding var isChecked: Bool
    var text: String
    var onToggle: ((Bool) -> Void)
    var action: () -> Void

    var body: some View {
        HStack {
            Toggle(isOn: $isChecked) {
                Text(text)
            }
            .toggleStyle(CheckboxToggleStyle { isChecked in
                self.isChecked = isChecked
                onToggle(isChecked)
            })
            Spacer()
                .onTapGesture {
                    self.isChecked.toggle()
                    onToggle(self.isChecked)
                }
            Button(
                action: action,
                label: {
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.accentColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 14)
                })
        }
        .padding(.leading, 10)
        .background(Color.gray.opacity(0.1))
    }
}
