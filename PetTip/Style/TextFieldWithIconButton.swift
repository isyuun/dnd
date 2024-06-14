//
//  TextFieldWithImage.swift
//  PetTip
//
//  Created by isyuun on 2024/6/12.
//

import SwiftUI

struct TextFieldWithIconButton: View {
    @State var title: LocalizedStringKey
    @Binding var text: String
    @State var image = UIImage(systemName: "chevron.forward")
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
                    Image(uiImage: image!)
                        .foregroundColor(Color.accentColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 14)
                }
            )
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
    TextFieldWithIconButton(
        title: "우리동네를 선택해 주세요",
        text: .constant(""),
        image: UIImage(systemName: "chevron.forward"),
        maxLength: 30
    ) {
        //
    }.padding()
}
