//
//  FooterView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/21.
//

import SwiftUI

struct FooterView: View {
    @State var show = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("고객센터 1:1 문의")
                Spacer()
                Text("제휴문의")
            }
            .padding(.top, 3)

            HStack {
                Text("주식회사 케어비즈 사업자 정보")
                    .padding(.trailing)
                Button(action: {
                    show.toggle()
                }) {
                    show ? Image(systemName: "chevron.up") : Image(systemName: "chevron.down")
                }
            }
            .onTapGesture {
                show.toggle()
            }
            .padding(.top, 3)

            if show {
                Text("상호명 : 케어비즈\n서비스명 : 펫팁\n대표이사 : 문형윤\n사업자 등록번호 : 289-88-01406\n통신판매중개자\n주소 : 서울시 성동구 아차산로17길 49\n\nⒸ CAREBIZ . INC ALL RIGHTS RESERVED.")
                    .foregroundColor(Color.gray)
                    .padding(.top, 0)
            }

            Text("이용약관 및 법적고지")
                .padding(.top, 3)
                .padding(.bottom, 3)
        }
        .environment(\.font, .system(size: .caption2))
        .padding()
        .background(.gray.opacity(0.1))
    }
}

#Preview {
    FooterView()
}
