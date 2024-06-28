//
//  PreviewView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/21.
//

import SwiftUI

struct PreviewView: View {
    var body: some View {
        VStack {
            Title("보기")
            Text(text: "보기")
                .font(.system(size: .body))
            Text("보기")
            Button("보기") {}
            Button("보기") {}
                .buttonStyle(.rectPrimary)
            Button("보기") {}
                .buttonStyle(.rectSecondary)
            Button("보기") {}
                .buttonStyle(.primary)
            Button("보기") {}
                .buttonStyle(.secondary)
            Button("보기") {}
                .buttonStyle(.tertiary)
            Button("보기") {}
                .buttonStyle(.primarySmall)
            Button("보기") {}
                .buttonStyle(.secondarySmall)
            Button("보기") {}
                .buttonStyle(.tertiarySmall)
            NavigationLink(destination: WalkMapView()) { Text("산책시작") }
            Spacer()
            FooterView()
        }
        // .environment(\.font, .system(size: .caption))
    }
}

#Preview {
    PreviewView()
}
