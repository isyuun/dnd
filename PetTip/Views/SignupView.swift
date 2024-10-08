//
//  SigninView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/12.
//

import SwiftUI

#Preview {
    SignupView(nick: .constant(""), email: .constant(""))
}

struct SignupView: View {
    @State var error: String = " "

    @Binding var nick: String
    @Binding var email: String

    @State var dong: String = ""

    @State private var isCheckedNick: Bool = false

    @State private var showingHometownSheet: Bool = false

    @State private var isCheckedAll: Bool = false
    // 사용자가 전체 동의 토글을 클릭했을 때의 핸들러
    private func handleToggleAll(_ isChecked: Bool) {
        isCheckedService = isChecked
        isCheckedPrivacy = isChecked
        isCheckedMarketting = isChecked
    }

    @State private var isCheckedService: Bool = false {
        didSet { updateAllCheckedStatus() }
    }

    @State private var isCheckedPrivacy: Bool = false {
        didSet { updateAllCheckedStatus() }
    }

    @State private var isCheckedMarketting: Bool = false {
        didSet { updateAllCheckedStatus() }
    }

    // 개별 체크박스가 변경될 때 호출되는 함수
    private func updateAllCheckedStatus() {
        isCheckedAll = isCheckedService && isCheckedPrivacy && isCheckedMarketting
    }

    @State private var showingAgreementsSheet: Bool = false
    @State private var selectedTab = 0

    var signupAuth: SignupAuth = .init()

    @State var showAlert = false
    @State var alertMessage = ""

    @FocusState private var isEdit: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("닉네임 중복을 확인해 주세요 *")
                    .bold()

                TextFieldWithTextButton(
                    title: "닉네임을 입력 해 주세요",
                    text: $nick,
                    button: "중복",
                    maxLength: 20)
                {
                    if nick.isEmpty {
                        isCheckedNick = false
                        showAlert = true
                        alertMessage = "닉네임을 입력해주세요."
                        return
                    }

                    if signupAuth.containsSpecialCharacter(input: nick) {
                        isCheckedNick = false
                        showAlert = true
                        alertMessage = "닉네임은 특수문자를 사용 할 수 없습니다."
                        return
                    }

                    signupAuth.checkNickName(nicknm: nick) { data, error in
                        if let statusCode = data?.statusCode {
                            if statusCode == 200 {
                                isCheckedNick = true
                                showAlert = true
                                alertMessage = "사용하실 수 있는 닉네임입니다."
                            } else if statusCode == 406 {
                                isCheckedNick = false
                                showAlert = true
                                alertMessage = "이미 사용중인 닉네임입니다."
                            }
                        }
                    }
                }
                .onChange(of: nick) { newValue in
                    isCheckedNick = false
                }
                .focused($isEdit)

                Text(error)
                    .padding(.bottom)
                    .foregroundColor(.orange)
                    .frame(minHeight: 32)

                TextFieldWithIconButton(
                    title: "우리동네를 선택해 주세요",
                    text: $dong,
                    image: UIImage(systemName: "chevron.forward"))
                {
                    //
                    showingHometownSheet = true
                }
                .focused($isEdit)

                Text("펫팁 회원가입을 위해\n약관에 동의해 주세요")
                    .bold()
                    .padding(.top, 36)
                    .padding(.bottom, 24)

                Group {
                    HStack {
                        Toggle(isOn: $isCheckedAll) {
                            Text("약관 전체동의").bold()
                        }
                        .toggleStyle(CheckboxToggleStyle { isChecked in
                            handleToggleAll(isChecked)
                        })
                        Spacer()
                    }

                    CheckBoxTextButton(
                        isChecked: $isCheckedService,
                        text: Text("[필수]서비스이용약관 동의"),
                        onToggle: { isChecked in
                            // 토글 상태 변경 처리
                            self.isCheckedService = isChecked
                        },
                        action: {
                            showingAgreementsSheet = true // 버튼 액션 정의
                            selectedTab = 0
                        })

                    CheckBoxTextButton(
                        isChecked: $isCheckedPrivacy,
                        text: Text("[필수]개인정보 수집·이용 동의"),
                        onToggle: { isChecked in
                            // 토글 상태 변경 처리
                            self.isCheckedPrivacy = isChecked
                        },
                        action: {
                            // 버튼 액션 정의
                            showingAgreementsSheet = true // 버튼 액션 정의
                            selectedTab = 1
                        })

                    CheckBoxTextButton(
                        isChecked: $isCheckedMarketting,
                        text: Text("[선택]마케팅 활용 동의"),
                        onToggle: { isChecked in
                            // 토글 상태 변경 처리
                            self.isCheckedMarketting = isChecked
                        },
                        action: {
                            // 버튼 액션 정의
                            showingAgreementsSheet = true // 버튼 액션 정의
                            selectedTab = 2
                        })
                }
                .disabled(!isCheckedNick)
            }
            .padding(20)
            .onAppear {
                error = "한글,영문 20글자까지 가능해요"
                // error = ""
                updateAllCheckedStatus()
            }
        }
        .environment(\.font, .system(size: .default))
        .padding(.top)
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            if isEdit {
                Button(action: {
                    isEdit = false
                }) {
                    Text("완료")
                        .font(.system(size: .body))
                }
            }
        }
        .sheet(isPresented: $showingAgreementsSheet, onDismiss: {
            updateAllCheckedStatus()
        }) {
            AgreementsView(
                selectedTab: $selectedTab,
                isCheckedService: $isCheckedService,
                isCheckedPrivacy: $isCheckedPrivacy,
                isCheckedMarketting: $isCheckedMarketting)
        }
        .sheet(isPresented: $showingHometownSheet, onDismiss: {
            //
        }) {
            NavigationView {
                HometownView()
            }
        }
        .alert(isPresented: $showAlert) {
            NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)]")
            return CustomAlert(
                title: Text("회원가입"),
                message: Text(alertMessage),
                dismissButton: .default("확인"))
        }

        Spacer()

        Button(action: {
            // requestRequiredPermissions()
        }) {
            Text("약관 동의하기")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .cornerRadius(10)
        }
        .padding()
        .disabled(!(isCheckedService && isCheckedPrivacy))
    }
}
