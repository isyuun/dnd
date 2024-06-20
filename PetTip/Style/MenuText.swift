//
//  MenuText.swift
//  PetTip
//
//  Created by isyuun on 2024/6/20.
//

import SwiftUI

struct MenuText: View {
    var text: String

    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: "chevron.forward")
                .padding(.horizontal, 10)
                .padding(.vertical, 14)
        }
        .padding(.leading, 10)
    }
}
