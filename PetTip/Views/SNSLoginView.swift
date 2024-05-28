//
//  SNSLoginView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/28.
//

import SwiftUI

private var divider: some View {
    HStack {
        Color.gray
            .frame(height: 0.5, alignment: .center)
        Text("또는")
            .foregroundColor(Color.gray)
            .font(.system(size: 12, weight: .regular))
        Color.gray
            .frame(height: 0.5, alignment: .center)
    }
}

struct SNSLoginView: View {
    var body: some View {
        HStack {
            Spacer()

            VStack(alignment: .center, spacing: 15) {

                Button("카카오로 시작하기") { }
                    .buttonStyle(.signButton(type: .kakao))

                Button("네이버로 시작하기") { }
                    .buttonStyle(.signButton(type: .naver))
                
                Button("Google로 시작하기") { }
                    .buttonStyle(.signButton(type: .google))
                
                Button("Apple로 시작하기") { }
                    .buttonStyle(.signButton(type: .apple))
                
                divider
                
                Button("이메일로 가입하기") { }
                    .buttonStyle(.signButton(type: .email))
            }

            Spacer()
        }
            .padding(20)
    } }

#Preview {
    SNSLoginView()
}
