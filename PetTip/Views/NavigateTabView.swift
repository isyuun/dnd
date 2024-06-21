//
//  NavigateTabView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/4.
//

import SwiftUI

#Preview {
    NavigateTabView(isLogin: .constant(true))
}

struct NavigateTabView: View {
    @State var show: Bool = false
    @Binding var isLogin: Bool

    @State private var selection = 0

    var body: some View {
        let selectable = Binding(
            get: { self.selection },
            set: { self.selection = $0
                show = false
            })
        ZStack {
            TabView(selection: selectable) {
                MainView()
                    .tabItem {
                        Image(systemName: "pawprint")
                        Text("산책")
                    }
                    .tag(1)

                StoryListView()
                    .tabItem {
                        Image(systemName: "message")
                        Text("팁톡")
                    }
                    .tag(2)

                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("홈")
                    }
                    .tag(0)

                MallView()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("팁몰")
                    }
                    .tag(3)

                MyPageView2()
                    .tabItem {
                        Image(systemName: "person")
                        Text("My")
                    }
                    .tag(4)
            }
            .onChange(of: selection) { newValue in
                show = false
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        if !show {
                            Button(action: {
                                // 알림 버튼 눌렀을 때의 액션
                            }) {
                                Image(systemName: "bell")
                                    .font(.system(size: 17.0))
                            }
                            Button(action: {
                                // 메뉴 버튼 눌렀을 때의 액션
                                self.show.toggle()
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .font(.system(size: 17.0))
                            }
                        } else {
                            XMarkButton {
                                self.show.toggle()
                            }
                        }
                    }
                }
            }

            SideView()
        }
    }

    @ViewBuilder
    private func SideView() -> some View {
        SideMenuView(show: $show, isLogin: $isLogin)
            // .navigationBarHidden(show)
            .padding(.bottom, 49)
    }
}
