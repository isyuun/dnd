//
//  ContentView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/27.
//

import SwiftUI

struct ContentView: View {
    @State var isLogin = true
    @State var isNeedLogin = false

    var body: some View {
        if !isNeedLogin {
            NaviateTabView()
        } else {
            SNSLoginView(isLogin: $isLogin)
        }
        // NavigationView {
        //     NaviateTabView()
        //         .toolbar {
        //         ToolbarItem(placement: .navigationBarLeading) {
        //             Button {
        //             } label: {
        //                 Image(systemName: "square.and.pencil")
        //             }
        //
        //         }
        //     }
        // }
    }
}

struct NaviateTabView: View {
    var body: some View {
        TabView {
            NaverMapView()
                .tabItem {
                    Image(systemName: "pawprint")
                    Text("산책")
                }
                .tag(1)

            TipTalkView()
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
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .tabViewStyle(PageTabViewStyle())
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home")
            .font(.largeTitle)
    }
}

struct SearchView: View {
    var body: some View {
        Text("Search")
            .font(.largeTitle)
    }
}

struct TipTalkView: View {
    var body: some View {
        Text("Favorites")
            .font(.largeTitle)
    }
}

struct MyPageView: View {
    var body: some View {
        Text("Profile")
            .font(.largeTitle)
    }
}

struct MallView: View {
    var body: some View {
        Text("Settings")
            .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
