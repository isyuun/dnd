//
//  Text.swift
//  PetTip
//
//  Created by isyuun on 2024/6/28.
//

import SwiftUI

extension Text {
    func outlined(text: String, font: Font, border: Color = .black, radius: CGFloat = 1) -> some View {
        self.background(
            Text(text)
                .font(font) // 글꼴 크기만 조절
                .foregroundColor(border)
                .offset(x: radius, y: radius)
        )
    }
}
