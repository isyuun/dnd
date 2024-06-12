//
//  TextFieldWithImage.swift
//  PetTip
//
//  Created by isyuun on 2024/6/12.
//

import SwiftUI

struct TextFieldWithImage: View {
    @State var title: LocalizedStringKey
    @Binding var text: String
    @State var button: String
    @State var action: () -> Void

    private let cornerRadius = 10.0

    var body: some View {
        ZStack(alignment: .bottom) {
            TextField(title, text: $text)
                .padding(.trailing, 25)
                .padding(9)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color(uiColor: .clear))
                        .background(Color.gray.opacity(0.1)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                        )
                )
            HStack(alignment: .center) {
                Spacer()
                Button(
                    action: action,
                    label: {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color(uiColor: .systemBlue))
                            .padding(.trailing, 10)
                            .padding(.vertical, 10)
                    }
                )
            }
        }
    }
}

#Preview {
    TextFieldWithImage(
        title: "닉네임을 입력 해 주세요",
        text: .constant(""),
        button: "중복"
    ) {}.padding()
}
