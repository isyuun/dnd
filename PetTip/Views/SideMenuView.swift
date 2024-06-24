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
                    .background(Color(UIColor.systemBackground))
                    .transition(.move(edge: .trailing))
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
                        .buttonStyle(.primarySmall)
                        .font(.caption2)
                        Button("로그아웃") {
                            loginAuth.logout()
                        }
                        .buttonStyle(.secondarySmall)
                        .font(.caption2)
                        NavigationLink(
                            destination: ProfileView(),
                            label: {
                                Image(systemName: "gearshape")
                            }
                        )
                        .buttonStyle(.tertiarySmall)
                        .font(.caption2)
                    }.onAppear {
                        guard let nckNm = UserDefaults.standard.string(forKey: "nckNm") else { return }
                        self.nickName = "\(nckNm)"
                    }
                    HStack {
                        NavigationLink(destination: PreviewView()) {
                            VStack(spacing: 10) {
                                Image(systemName: "bell")
                                    .font(.title)
                                Text("알림")
                                    .bold()
                            }
                            .frame(maxWidth: .infinity) // 버튼의 최대 너비를 확장
                        }
                        NavigationLink(destination: PreviewView()) {
                            VStack(spacing: 10) {
                                Image(systemName: "bookmark")
                                    .font(.title)
                                Text("찜")
                                    .bold()
                            }
                            .frame(maxWidth: .infinity) // 버튼의 최대 너비를 확장
                        }
                        NavigationLink(destination: PreviewView()) {
                            VStack(spacing: 10) {
                                Image(systemName: "p.circle")
                                    .font(.title)
                                Text("포인트")
                                    .bold()
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
                        .buttonStyle(.primarySmall)
                        .font(.footnote)
                        Button("회원가입") {
                            //
                        }
                        .buttonStyle(.tertiarySmall)
                        .font(.footnote)
                        Spacer()
                    }.padding()
                }
            }
            .padding()
            .background(back)
            List {
                NavigationLink(destination: WalkMapView()) { Text("산책시작") }
                NavigationLink(destination: PreviewView()) { Text("펫등록관리") }
                NavigationLink(destination: PreviewView()) { Text("초대관리") }
                NavigationLink(destination: PreviewView()) { Text("구매관리") }
                NavigationLink(destination: PreviewView()) { Text("판매관리") }
                NavigationLink(destination: PreviewView()) { Text("우리동네맞춤지도") }
                NavigationLink(destination: PreviewView()) { Text("채팅") }
                NavigationLink(destination: PreviewView()) { Text("후기/댓글") }
                NavigationLink(destination: PreviewView()) { Text("알림내역") }
                NavigationLink(destination: QnAView()) { Text("1:1문의") }
                NavigationLink(destination: NoticeView()) { Text("공지사항") }
                NavigationLink(destination: FaqView()) { Text("FAQ") }
                NavigationLink(destination: EventView()) { Text("이벤트") }
                NavigationLink(destination: PreviewView()) { Text("설정") }
                NavigationLink(destination: PreviewView()) { Text("제휴상담문의") }
            }
            .listStyle(PlainListStyle())
            // .padding(0)
            // .background(back)
            Spacer()
        }
        .environment(\.font, .system(size: 15))
        .padding()
    }
}

#Preview {
    SideMenuView(show: .constant(true), isLogin: .constant(true))
        .environment(\.font, .system(size: 14))
}
