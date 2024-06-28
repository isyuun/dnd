//
//  Style.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

func divider(text: Text) -> some View {
    return HStack {
        Color.gray
            .frame(height: 0.5, alignment: .center)
        text
        Color.gray
            .frame(height: 0.5, alignment: .center)
    }
}

struct XMarkButton: View {
    var action: () -> Void

    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                Image(systemName: "xmark")
                    .font(.headline)
            }
        )
    }
}

func Text(text: String) -> some View {
    return Text(text)
}

func Title(_ text: String) -> some View {
    return Text(text)
        .font(.system(size: .largeTitle, weight: .bold))
        .navigationTitle(text)
}

func MenuText(_ text: String) -> some View {
    return HStack {
        Text(text)
        Spacer()
        Image(systemName: "chevron.forward")
            .padding(.horizontal, 10)
            .padding(.vertical, 14)
    }
    .padding(.leading, 10)
}
