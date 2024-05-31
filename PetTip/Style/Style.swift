//
//  Style.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

var divider: some View {
    // var text = Text("또는").font(.system(size: 12, weight: .regular))

    return HStack {
        Color.gray
            .frame(height: 0.5, alignment: .center)
        Text("또는")
            .font(.system(size: 12, weight: .regular))
        Color.gray
            .frame(height: 0.5, alignment: .center)
    }
}
