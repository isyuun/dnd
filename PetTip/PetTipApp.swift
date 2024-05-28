//
//  PetTipApp.swift
//  PetTip
//
//  Created by isyuun on 2024/5/27.
//

import SwiftUI
import NaverThirdPartyLogin

@main
struct PetTipApp: App {
    init() {
        //naver
        // 네이버 앱으로 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
        // 브라우저 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
    
        // 네이버 로그인 세로모드 고정
        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
    
        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
        // URL scheme
        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = kServiceAppUrlScheme
        // 클라이언트 아이디
        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = kConsumerKey
        // 시크릿 아이디
        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = kConsumerSecret
        // 앱 이름
        NaverThirdPartyLoginConnection.getSharedInstance().appName = kServiceAppName
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
            //     .onOpenURL { url in
            //     if NaverThirdPartyLoginConnection
            //         .getSharedInstance()
            //         .isNaverThirdPartyLoginAppschemeURL(url)
            //     {
            //         // Token 발급 요청
            //         NaverThirdPartyLoginConnection
            //             .getSharedInstance()
            //             .receiveAccessToken(url)
            //     }
            // }
        }
    }
}
