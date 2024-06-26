//
//  FindUserView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/26.
//

import SwiftUI

struct FindUserView: View {
    @Binding var nick: String
    @Binding var email: String

    var body: some View {
        Title("계정찾기")
    }
}

#Preview {
    FindUserView(nick: .constant("닉네임"), email: .constant("이메일"))
}
