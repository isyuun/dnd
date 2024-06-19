//
//  Style.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

func divider(text: Text) -> some View {
    // let _text = Text("또는").font(.system(size: 12, weight: .regular))
    let _text = text

    return HStack {
        Color.gray
            .frame(height: 0.5, alignment: .center)
        // Text("또는")
        //     .font(.system(size: 12, weight: .regular))
        _text
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
