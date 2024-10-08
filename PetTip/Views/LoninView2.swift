//
//  LoginView2.swift
//  PetTip
//
//  Created by isyuun on 2024/5/28.
//

import SwiftUI
import AuthenticationServices

#Preview {
    LoginView2(isLogin: .constant(false))
}

struct LoginView2: View {
    @State var showAlert = false
    @State var isSigninViewActive = false

    @ObservedObject var loginAuth: LoginAuth
    @Binding var isLogin: Bool

    @State var login: Login? = nil
    @State var error: MyError? = nil

    init(isLogin: Binding<Bool>) {
        self._isLogin = isLogin
        self.loginAuth = LoginAuth(isLogin: isLogin)
    }

    private func handleLoginResponse(login: Login?, error: MyError?) {
        isSigninViewActive = !isLogin
        self.login = login
        self.error = error
    }

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("간편인증을 해 주세요")
                .bold()
                .font(.system(size: .title3))
                .padding(.bottom, 24)

            Button("카카오톡으로 로그인") {
                self.loginAuth.startKakaoLogin { login, error in
                    NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][isLogin:\(self.isLogin)][\(String(describing: login))][\(String(describing: error))]")
                    self.handleLoginResponse(login: login, error: error)
                }
            }
            .buttonStyle(.signButton(type: .kakao))

            Button("네이버로 로그인") {
                self.loginAuth.startNaverLogin { login, error in
                    NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][isLogin:\(self.isLogin)][\(String(describing: login))][\(String(describing: error))]")
                    self.handleLoginResponse(login: login, error: error)
                }
            }
            .buttonStyle(.signButton(type: .naver))

            Button("구글로 로그인") {
                self.loginAuth.startGoogleLogin { login, error in
                    NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][isLogin:\(self.isLogin)][\(String(describing: login))][\(String(describing: error))]")
                    self.handleLoginResponse(login: login, error: error)
                }
            }
            .buttonStyle(.signButton(type: .google))

            Button("애플로 로그인") {
                self.loginAuth.startAppleLogin { login, error in
                    NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][isLogin:\(self.isLogin)][\(String(describing: login))][\(String(describing: error))]")
                    self.handleLoginResponse(login: login, error: error)
                }
            }
            .buttonStyle(.signButton(type: .apple))

            HStack {
                Spacer()
                NavigationLink(destination: FindUserView(nick: self.$loginAuth.nick, email: self.$loginAuth.email)) {
                    Text("어디로 가입한지 잊었어요!")
                        .font(.system(size: .caption))
                        .foregroundColor(.primary)
                        .underline()
                }
            }
        }
        .environment(\.font, .system(size: .body))
        .padding(20)
        .alert(isPresented: $showAlert) {
            NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)]")
            return CustomAlert(
                title: Text("알림"),
                message: Text("[\(String(describing: self.error?.resCode))]\n로그인 오류입니다."),
                dismissButton: .default("확인") {
                    if self.login == nil {
                        self.isSigninViewActive = true
                    }
                }
            )
        }
        .overlay(
            NavigationLink(destination: SignupView(nick: $loginAuth.nick, email: $loginAuth.email).navigationTitle("회원가입"), isActive: $isSigninViewActive) {
                EmptyView()
            }
        )
    }
}
