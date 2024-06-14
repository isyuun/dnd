//
//  NavigateTabView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/4.
//

import SwiftUI

#Preview {
    NavigateTabView()
}

struct NavigateTabView: View {
    @State private var selection = 1

    var body: some View {
        TabView(selection: $selection) {
            WalkView()
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
                .tag(4)

            MyPageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("My")
                }
                .tag(3)
        }
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

struct ProfileView: View {
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
