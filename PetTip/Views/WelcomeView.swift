//
//  WelcomeView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/13.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isLogin: Bool
    @Binding var isWelcomeViewActive: Bool

    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                SplashView(text: "펫&집사 함께하는 행복한 동행\n꿀팁!! 커뮤니티+쇼핑+산책!!", image: UIImage(named: "character"))
                    .tag(0)
                if !isLogin {
                    SplashView(color: Color(.darkText), text: "펫, 함께 케어해요~\n허심탄회하게 TALK하는 팁톡!!", back: UIImage(named: "img_story1"))
                        .tag(1)
                    SplashView(color: Color(.darkText), text: "직거래 펫팁몰로\n알차게 SAVE 하는 집사의 품격!!", back: UIImage(named: "img_story2"))
                        .tag(2)
                    SplashView(color: Color(.darkText), text: "즐기다보니,\n포인트 모으GO\n포인트 쓰GO", back: UIImage(named: "img_story3"))
                        .tag(3)
                }
            }
            .tabViewStyle(.page)

            if (isLogin && selectedTab == 0) || selectedTab == 3 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("건너뛰기")
                            .font(.headline)
                            .foregroundColor(.white)
                            .underline()
                            .padding()
                            .onTapGesture {
                                isWelcomeViewActive = false
                            }
                    }
                }
            }
        }
    }
}

struct SplashView: View {
    var color = Color(.lightText)
    var text: String = ""
    var image: UIImage?
    var back: UIImage?

    init(color: Color = Color(.white), text: String = "", image: UIImage? = nil, back: UIImage? = nil) {
        self.color = color
        self.text = text
        self.image = image
        self.back = back
    }

    var body: some View {
        VStack {
            Spacer()
            if let image = image { Image(uiImage: image) }
            HStack {
                Spacer()
                Text(text)
                    .font(.title2)
                    .foregroundColor(color)
                Spacer()
            }
            .padding(20)
            Spacer()
        }
        .background(
            Group {
                if let back = back {
                    Image(uiImage: back)
                        .resizable()
                        .scaledToFill()
                } else {
                    Color(UIColor(hexCode: "#5079DD"))
                }
            }
        )
        .clipped() // 이미지가 배경을 넘어서지 않도록 자름
    }
}

#Preview {
    WelcomeView(isLogin: .constant(false), isWelcomeViewActive: .constant(true))
}
