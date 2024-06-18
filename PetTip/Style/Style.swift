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
    var body: some View {
        Image(systemName: "xmark") // changed to image, can change color here if needed
        // .font(.headline)
    }
}
