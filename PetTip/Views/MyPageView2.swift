//
//  MyPageView2.swift
//  PetTip
//
//  Created by isyuun on 2024/6/18.
//

import SwiftUI

struct MyPageView2: View {
    @Binding var isLogin: Bool

    var body: some View {
        Title("마이")
    }
}

#Preview {
    MyPageView2(isLogin: .constant(true))
}
