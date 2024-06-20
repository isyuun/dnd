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
        // Text("또는")
        //     .font(.system(size: 12, weight: .regular))
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

func Title(_ title: String) -> some View {
    return Text(title)
}

func MenuTitle(_ title: String) -> some View {
    return HStack {
        Text(title)
        Spacer()
        Image(systemName: "chevron.forward")
            .padding(.horizontal, 10)
            .padding(.vertical, 14)
    }
    .padding(.leading, 10)
}
