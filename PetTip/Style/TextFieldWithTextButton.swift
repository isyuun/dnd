//
//  TextFieldWithTextButton.swift
//  PetTip
//
//  Created by isyuun on 2024/6/12.
//

import SwiftUI

struct TextFieldWithTextButton: View {
    @State var title: LocalizedStringKey
    @Binding var text: String
    @State var button: String
    var maxLength: Int? // 최대 입력 길이

    @State var action: () -> Void

    private let cornerRadius = 10.0

    var body: some View {
        HStack {
            TextField(title, text: $text)
                .padding(9)
                .onChange(of: text) { newValue in
                    guard let maxLength = maxLength else { return }
                    if newValue.count > maxLength {
                        text = String(newValue.prefix(maxLength))
                    }
                }
            Button(
                action: action,
                label: {
                    Text(button)
                }
            )
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
            .foregroundColor(Color.white)
            .background(Color.accentColor)
            .cornerRadius(cornerRadius)
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(Color(uiColor: .clear))
                .background(Color.gray.opacity(0.1)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                )
        )
    }
}

#Preview {
    TextFieldWithTextButton(
        title: "닉네임을 입력 해 주세요",
        text: .constant(""),
        button: "중복",
        maxLength: 30
    ) {
        //
    }.padding()
}
