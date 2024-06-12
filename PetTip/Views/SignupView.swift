//
//  SigninView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/12.
//

import SwiftUI

struct SignupView: View {
    @State var error: String = " "
    @State var nick: String = ""
    @State var dong: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("닉네임 중복을 확인해 주세요 *")
                TextFieldWithButton(
                    title: "닉네임을 입력 해 주세요",
                    text: $nick,
                    button: "중복") {}
                Text(error)
                    .font(.footnote)
                    .padding(.bottom)
                TextFieldWithImage(
                    title: "우리동네를 선택해 주세요",
                    text: $dong,
                    button: "중복") {}
            }
            .padding(20)
            .onAppear {
                error = "한글 10글자, 영문20글자까지 가능해요"
            }
        }.padding(.top)

        Spacer()

        Button(action: {
            // requestRequiredPermissions()
        }) {
            Text("약관 동의하기")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding()
        .navigationTitle("회원가입")
    }
}

#Preview {
    SignupView()
}
