//
//  Style.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

func divider(text: Text) -> some View {
    return HStack {
        Color.gray
            .frame(height: 0.5, alignment: .center)
        text
        // .font(.system(size: 12, weight: .regular))
        Color.gray
            .frame(height: 0.5, alignment: .center)
    }
}

struct XMarkButton: View {
    var action: () -> Void

    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                Image(systemName: "xmark")
                    .font(.headline)
            }
        )
    }
}

func Title(_ title: String) -> some View {
    return Text(title).navigationTitle(title).font(.largeTitle)
}

func MenuText(_ text: String) -> some View {
    return HStack {
        Text(text)
        Spacer()
        Image(systemName: "chevron.forward")
            .padding(.horizontal, 10)
            .padding(.vertical, 14)
    }
    .padding(.leading, 10)
}

func FooterView() -> some View {
    @State var show = false

    return VStack(alignment: .leading) {
        Divider()
        HStack {
            Text("고객센터 1:1 문의")
            Spacer()
            Text("제휴문의")
        }.padding(.vertical)
        HStack {
            Text("주식회사 케어비즈 사업자 정보")
            Spacer()
            if show {
                Button(action: {
                    show.toggle()
                }) {
                    Image(systemName: "chevron.up")
                }
            } else {
                Button(action: {
                    show.toggle()
                }) {
                    Image(systemName: "chevron.down")
                }
            }
            Spacer()
        }.padding(.vertical)
        if show {
            Text("상호명 : 케어비즈\n서비스명 : 펫팁\n대표이사 : 문형윤\n사업자 등록번호 : 289-88-01406\n통신판매중개자\n주소 : 서울시 성동구 아차산로17길 49\n\nⒸ CAREBIZ . INC ALL RIGHTS RESERVED.")
                .padding(.bottom)
        }
        Text("이용약관 및 법적고지")
            .padding(.vertical)
    }.padding()
}

#Preview {
    FooterView()
}
