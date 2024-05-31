//
//  ContentView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/27.
//

import SwiftUI

struct ContentView: View {
    @State var isLogin = false

    var body: some View {
        let isNeedLogin = !isLogin
        let v = if !isNeedLogin {
            AnyView(NaviateTabView())
        } else {
            AnyView(SNSLoginView(isLogin: $isLogin))
        }
        NavigationView {
            v.navigationTitle(Text("PetTip"))
        }
    }
}

struct NaviateTabView: View {
    var body: some View {
        TabView {
            WalkListView()
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

            MainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
                .tag(0)

            MallView()
                .tabItem {
                    Image(systemName: "carrot")
                    Text("팁몰")
                }
                .tag(4)

            MyPageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("My")
                }
                .tag(3)
        }
        // .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        // .tabViewStyle(PageTabViewStyle())
    }
}

struct HomeView: View {
    var body: some View {
        Text("홈")
            .font(.largeTitle)
    }
}

struct SearchView: View {
    var body: some View {
        Text("검색")
            .font(.largeTitle)
    }
}

struct TipTalkView: View {
    var body: some View {
        Text("팁톡")
            .font(.largeTitle)
    }
}

struct Profile: View {
    var body: some View {
        Text("마이")
            .font(.largeTitle)
    }
}

struct MallView: View {
    var body: some View {
        Text("팁몰")
            .font(.largeTitle)
    }
}

#Preview {
    ContentView(isLogin: true)
}
