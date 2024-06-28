//
//  File.swift
//  PetTip
//
//  Created by isyuun on 2024/6/28.
//

import SwiftUI

extension CGFloat {
    static var `default`: CGFloat = 14
    static var largeTitle: CGFloat = 34
    static var title: CGFloat = 28
    static var title2: CGFloat = 22
    static var title3: CGFloat = 20
    static var headline: CGFloat = 17
    static var subheadline: CGFloat = 15
    static var body: CGFloat = 17
    static var body2: CGFloat = 15
    static var callout: CGFloat = 16
    static var footnote: CGFloat = 13
    static var caption: CGFloat = 12
    static var caption2: CGFloat = 11
}

struct FontDemoView: View {
    var body: some View {
        VStack(spacing: 20){
            Text("default(14pt)").font(.system(size: .default))
            Text("largeTitle(34pt)").font(.system(size: .largeTitle))
            Text("title(28pt)").font(.system(size: .title))
            Text("title2(22pt)").font(.system(size: .title2))
            Text("title3(20pt)").font(.system(size: .title3))
            Text("headline(17pt)").font(.system(size: .headline))
            Text("subheadline(15pt)").font(.system(size: .subheadline))
            Text("body(17pt)").font(.system(size: .body))
            Text("body2(15pt)").font(.system(size: .body2))
            Text("callout(16pt)").font(.system(size: .callout))
            Text("footnote(13pt)").font(.system(size: .footnote))
            Text("caption(12pt)").font(.system(size: .caption))
            Text("caption2(11pt)").font(.system(size: .caption2))
        }
    }
}

#Preview {
    FontDemoView()
}
