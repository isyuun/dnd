//
//  AgreementsView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/17.
//

import SwiftUI

struct AgreementsView: View {
    @Environment(\.dismiss) private var dismiss // moved dismiss functionality here

    @Binding var selectedTab: Int

    @Binding var isCheckedService: Bool

    @Binding var isCheckedPrivacy: Bool

    @Binding var isCheckedMarketting: Bool

    @State private var isClickService: Bool = false

    @State private var isClickPrivacy: Bool = false

    @State private var isClickMarketting: Bool = false

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                AgreementView(url: URL(string: "https://pettip.net/terms")!,
                              check: $isCheckedService,
                              action: {
                                  isClickService = true
                                  if isClickService, isClickPrivacy, isClickMarketting {
                                      dismiss()
                                  }
                                  if !isClickPrivacy {
                                      selectedTab = 1
                                  } else {
                                      selectedTab = 2
                                  }
                              })
                              .tag(0)
                              // .navigationTitle("서비스이용약관 동의")
                AgreementView(url: URL(string: "https://pettip.net/privacy_policy")!,
                              check: $isCheckedPrivacy,
                              action: {
                                  isClickPrivacy = true
                                  if isClickService, isClickPrivacy, isClickMarketting {
                                      dismiss()
                                  }
                                  if !isClickMarketting {
                                      selectedTab = 2
                                  } else {
                                      selectedTab = 1
                                  }
                              })
                              .tag(1)
                              // .navigationTitle("개인정보 수집·이용 동의")
                AgreementView(url: URL(string: "https://pettip.net/marketing")!,
                              check: $isCheckedMarketting,
                              action: {
                                  isClickMarketting = true
                                  if isClickService, isClickPrivacy, isClickMarketting {
                                      dismiss()
                                  }
                                  if !isClickService {
                                      selectedTab = 0
                                  } else {
                                      selectedTab = 1
                                  }
                              })
                              .tag(2)
                              // .navigationTitle("마케팅 활용 동의")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .tabViewStyle(.page)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("약관동의")
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

struct AgreementView: View {
    let url: URL
    @Binding var check: Bool
    var action: () -> Void

    var body: some View {
        VStack {
            WebView(url: url)
            Toggle(isOn: $check) {
                //
            }.toggleStyle(ButtonToggleStyle { isChecked in
                self.check = isChecked
                action()
            })
        }
    }
}

#Preview {
    AgreementsView(selectedTab: .constant(0), isCheckedService: .constant(false), isCheckedPrivacy: .constant(false), isCheckedMarketting: .constant(false))
}
