//
//  ShowMenuView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/18.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var show: Bool
    @Binding var isLogin: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            if self.show {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()

                SideMenuViewContents(show: self.$show, isLogin: self.$isLogin)
                    .transition(.move(edge: .trailing))
                    .background(
                        Color.white
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .animation(.easeInOut, value: show)
        .onAppear {
            self.isLogin = UserDefaults.standard.value(forKey: "accessToken") != nil
        }
    }
}

struct SideMenuViewContents: View {
    @Binding var show: Bool

    var loginAuth: LoginAuth
    @Binding var isLogin: Bool

    @State var nickName: String = ""

    init(show: Binding<Bool>, isLogin: Binding<Bool>) {
        self._show = show
        self._isLogin = isLogin
        self.loginAuth = LoginAuth(isLogin: isLogin)
    }

    var body: some View {
        VStack {
            let back = RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(Color(uiColor: .clear))
                .background(Color.gray.opacity(0.1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                )
            // HStack {
            //     Spacer()
            //     XMarkButton {
            //         self.show.toggle()
            //     }
            // }
            VStack {
                if isLogin {
                    HStack {
                        Text(nickName)
                            .font(.title2)
                        Spacer()
                        NavigationLink(
                            destination: ProfileView(),
                            label: {
                                Text("정보관리")
                            }
                        )
                        .buttonStyle(.primarySmallButton)
                        .font(.footnote)
                        Button("로그아웃") {
                            loginAuth.logout()
                        }
                        .buttonStyle(.primarySmallButton)
                        .font(.footnote)
                    }.onAppear {
                        guard let nckNm = UserDefaults.standard.string(forKey: "nckNm") else { return }
                        self.nickName = "\(nckNm)"
                    }
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                            VStack(spacing: 10) {
                                Image(systemName: "bell")
                                    .font(.title)
                                Text("알림")
                            }
                            .frame(maxWidth: .infinity) // 버튼의 최대 너비를 확장
                        }
                        NavigationLink(destination: ProfileView()) {
                            VStack(spacing: 10) {
                                Image(systemName: "bookmark")
                                    .font(.title)
                                Text("찜")
                            }
                            .frame(maxWidth: .infinity) // 버튼의 최대 너비를 확장
                        }
                        NavigationLink(destination: ProfileView()) {
                            VStack(spacing: 10) {
                                Image(systemName: "p.circle")
                                    .font(.title)
                                Text("포인트")
                            }
                            .frame(maxWidth: .infinity) // 버튼의 최대 너비를 확장
                        }
                    }.padding(.top)
                } else {
                    Text("다양한 펫팁 서비스는\n") + Text("로그인 후 사용가능해요").bold()
                    HStack {
                        Spacer()
                        Button("로그인") {
                            //
                        }
                        .buttonStyle(.primarySmallButton)
                        .font(.footnote)
                        Button("회원가입") {
                            //
                        }
                        .buttonStyle(.primarySmallButton)
                        .font(.footnote)
                        Spacer()
                    }.padding()
                }
            }
            .padding()
            .background(back)
            ScrollView {
                VStack {
                    NavigationLink(destination: ProfileView()) { MenuTitle("펫등록관리") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("초대관리") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("구매관리") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("판매관리") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("우리동네맞춤지도") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("채팅") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("후기/댓글") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("알림내역") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("1:1문의") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("공지사항") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("FAQ") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("이벤트") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("설정") }.foregroundColor(.primary)
                    NavigationLink(destination: ProfileView()) { MenuTitle("제휴상담문의") }.foregroundColor(.primary)
                }
            }
            // .padding()
            // .background(back)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SideMenuView(show: .constant(true), isLogin: .constant(true))
}
