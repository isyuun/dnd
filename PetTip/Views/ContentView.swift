//
//  ContentView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/27.
//

import SwiftUI
import NaverThirdPartyLogin
import KakaoSDKCommon
import KakaoSDKAuth
import AuthenticationServices

struct ContentView: View {
    @State var isLogin = false

    var body: some View {
        if self.isLogin {
            NavigationView()
        } else {
            SNSLoginView(isLogin: self.$isLogin)  // @Binding으로 연결
                // .onOpenURL(perform: { url in
                // NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][\(url)]")
                // if (AuthApi.isKakaoTalkLoginUrl(url)) {
                //     isLogin = AuthController.handleOpenUrl(url: url)
                // }
                // NaverThirdPartyLoginConnection
                //     .getSharedInstance()
                //     .receiveAccessToken(url)
            // })
        }
    }
}

struct NavigationView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
                .tag(0)

            SearchView()
                .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
                .tag(1)

            FavoritesView()
                .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
                .tag(2)

            ProfileView()
                .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
                .tag(3)

            SettingsView()
                .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
                .tag(4)
        }
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

struct FavoritesView: View {
    var body: some View {
        Text("Favorites")
            .font(.largeTitle)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile")
            .font(.largeTitle)
    }
}

struct SettingsView: View {
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
