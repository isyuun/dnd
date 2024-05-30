//
//  SNSLoginView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/28.
//

import SwiftUI
import AuthenticationServices

private var divider: some View {
    var text: String = "또는"

    return HStack {
        Color.gray
            .frame(height: 0.5, alignment: .center)
        Text(text)
            .font(.system(size: 12, weight: .regular))
        Color.gray
            .frame(height: 0.5, alignment: .center)
    }
}

struct SNSLoginView: View {
    var loginAuth: LoginAuth
    @State private var showAlert = false // 얼럿을 표시하기 위한 상태 변수

    @Binding var isLogin: Bool

    init(isLogin: Binding<Bool>) {
        _isLogin = isLogin
        loginAuth = LoginAuth(isLogin: isLogin)
    }

    var body: some View {
        HStack {
            Spacer()

            VStack(alignment: .center, spacing: 15) {

                divider

                Button("카카오톡으로 로그인") {
                    loginAuth.startKakaoLogin() { login, error in
                        NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][isLogin:\(isLogin)][\(String(describing: login))][\(String(describing: error))]")
                        self.showAlert = !self.isLogin
                    }
                }
                    .buttonStyle(.signButton(type: .kakao))

                Button("네이버로 로그인") {
                    loginAuth.startNaverLogin() { login, error in
                        NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][isLogin:\(isLogin)][\(String(describing: login))][\(String(describing: error))]")
                        self.showAlert = !self.isLogin
                    }
                }
                    .buttonStyle(.signButton(type: .naver))

                Button("구글로 로그인") {
                    loginAuth.startGoogleLogin { login, error in
                        NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][isLogin:\(isLogin)][\(String(describing: login))][\(String(describing: error))]")
                        self.showAlert = !self.isLogin
                    }
                }
                    .buttonStyle(.signButton(type: .google))

                Button("애플로 로그인") {
                    loginAuth.startAppleLogin()
                }
                    .buttonStyle(.signButton(type: .apple))

                divider

                Button("이메일로 가입하기") { }
                    .buttonStyle(.signButton(type: .email))
            }

            Spacer()
        }
            .alert(isPresented: $showAlert) {
            Alert(title: Text("알림"), message: Text("로그인 오류입니다."), dismissButton: .default(Text("확인")))
        }
            .padding(20)
    }
}

#Preview {
    SNSLoginView(isLogin: .constant(false))
}
