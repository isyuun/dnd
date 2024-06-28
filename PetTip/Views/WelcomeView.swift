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
    private func dismiss() {
        isWelcomeViewActive = false
    }

    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                SplashView(sel: $selectedTab, tag: 0, text: "펫&집사 함께하는 행복한 동행\n꿀팁!! 커뮤니티+쇼핑+산책!!", image: UIImage(named: "character"))
                    .tag(0)
                if !isLogin {
                    SplashView(sel: $selectedTab, tag: 1, text: "펫, 함께 케어해요~\n허심탄회하게 TALK하는 팁톡!!", back: UIImage(named: "img_story1"))
                        .tag(1)
                    SplashView(sel: $selectedTab, tag: 2, text: "직거래 펫팁몰로\n알차게 SAVE 하는 집사의 품격!!", back: UIImage(named: "img_story2"))
                        .tag(2)
                    SplashView(sel: $selectedTab, tag: 3, text: "즐기다보니,\n포인트 모으GO\n포인트 쓰GO", back: UIImage(named: "img_story3"))
                        .tag(3)
                }
            }
            .tabViewStyle(.page)

            HStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            if selectedTab > 0 {
                                selectedTab -= 1
                            }
                            NSLog("[LOG][I][(\(#fileID):\(#line))::onTapGesture][\(selectedTab)]")
                        }
                    }
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            if selectedTab < (isLogin ? 1 : 3) {
                                selectedTab += 1
                            }
                            NSLog("[LOG][I][(\(#fileID):\(#line))::onTapGesture][\(selectedTab)]")
                        }
                        if selectedTab == (isLogin ? 1 : 3) {
                            dismiss()
                        }
                    }
            }

            if isLogin ? selectedTab == 0 : selectedTab == 3 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Text("건너뛰기")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.white)
                                .underline()
                                .padding()
                        }
                    }
                }
            } // 건너뛰기
        }
    }
}

struct SplashView: View {
    @State private var isTextShown = false
    let textOffset: CGSize

    var color = Color(.lightText)
    var border = Color(.black)
    var text: String = ""
    var image: UIImage?
    var back: UIImage?

    @Binding var sel: Int
    let tag: Int

    init(sel: Binding<Int>, tag: Int, color: Color = .white, border: Color = .black, text: String = "", image: UIImage? = nil, back: UIImage? = nil) {
        _sel = sel
        self.tag = tag
        self.color = color
        self.border = border
        self.text = text
        self.image = image
        self.back = back
        var width: CGFloat
        repeat {
            width = UIScreen.main.bounds.width * CGFloat(Int.random(in: -1 ... 1))
        } while width == 0.0
        textOffset = CGSize(width: width, height: 0)
    }

    public func animate() {
        withAnimation(.easeInOut(duration: 0.5)) {
            NSLog("[LOG][I][(\(#fileID):\(#line))::animate][\(tag)][\(isTextShown)][\(textOffset)]")
            isTextShown = true
        }
    }

    var body: some View {
        VStack {
            Spacer()
            if let image = image { Image(uiImage: image) }
            HStack {
                Spacer()
                let font = Font.system(size: .title2).bold()
                Text(text)
                    .font(font)
                    .foregroundColor(color)
                    .outlined(text: text, font: font)
                    .offset(isTextShown ? .zero : textOffset)
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
        .onAppear {
            if tag == 0 {
                NSLog("[LOG][I][(\(#fileID):\(#line))::onAppear][\(tag)][\(isTextShown)][\(textOffset)]")
                animate()
            }
        }
        .onChange(of: sel) { newValue in
            if newValue == tag {
                NSLog("[LOG][I][(\(#fileID):\(#line))::onChange][\(tag)][\(isTextShown)][\(textOffset)]")
                animate()
            }
        }
    }
}

#Preview {
    WelcomeView(isLogin: .constant(false), isWelcomeViewActive: .constant(true))
}
