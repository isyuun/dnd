//
//  HometownView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/17.
//

import SwiftUI

struct HometownView: View {
    @Environment(\.dismiss) private var dismiss // moved dismiss functionality here

    @StateObject private var locationManager = LocationManager()
    @State private var address: String = ""

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    NaverMap(centerCoordinate: $locationManager.currentLocation, address: $address)
                        .onAppear {
                            locationManager.requestLocation()
                        }
                        .frame(height: 360)
                }
                Spacer()
                Text("현 위치 ")+Text("‘\(address)’").font(.title3)+Text("을 우리동네로\n선택하시겠어요?")
                Spacer()
                Text("우리동네로 선택시\n1. 판매상품 등록할 경우\n    선택된 동네 위치 인증후 등록 가능해요\n2. 상품 구매할 경우\n    선택된 동네위치로 상품조회가 가능해요")
                Spacer()
                HStack {
                    Button(action: {
                        locationManager.requestLocation()
                    }) {
                        Text("다시 시도")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.secondary)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        //
                    }) {
                        Text("우리동네로 선택하기")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("우리동네설정")
                        .font(.title2)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    XMarkButton().onTapGesture { // on tap gesture calls dismissal
                        dismiss()
                    }
                }
            })
        }
    }
}

#Preview {
    HometownView()
}
