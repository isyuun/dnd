//
//  LoginAuth.swift
//  PetTip
//
//  Created by isyuun on 2024/5/29.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import AuthenticationServices
import GoogleSignIn

private var completionHandlerKey: UInt8 = 0

class LoginAuth: NSObject, ObservableObject {
    @Binding var isLogin: Bool

    init(isLogin: Binding<Bool>) {
        _isLogin = isLogin
    }

    private func snsLogin(userId: String, userPw: String, userNick: String = "", loginMethod: String, completion: @escaping (_ succeed: Login?, _ failed: MyError?) -> Void) {
        let request = LoginRequest(appTypNm: Util.getModel(), userID: userId, userPW: userPw)
        MemberAPI.login(request: request) { login, error in
            NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][\(String(describing: login))][\(String(describing: error))]")
            self.isLogin = false
            if let login = login {
                let userDef = UserDefaults.standard
                userDef.set(login.accessToken, forKey: "accessToken")
                userDef.set(login.refreshToken, forKey: "refreshToken")
                userDef.set(login.userId, forKey: "userId")
                userDef.set(login.email, forKey: "email")
                userDef.set(login.nckNm, forKey: "nckNm")
                userDef.set(loginMethod, forKey: "method")
                userDef.synchronize()
                self.trmnlMng(appKeyVl: login.appKeyVl)
                self.isLogin = true
            }
            completion(login, error)
        }
    }

    private func trmnlMng(appKeyVl: String?) {
        if (appKeyVl == nil || appKeyVl == "") || appKeyVl != Global.appKey {
            let request = TrmnlMngRequest(appKey: Global.appKey, appOs: "002", appTypNm: Util.getModel())
            MemberAPI.trmnlMng(request: request) { login, error in
                NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][\(String(describing: login))][\(String(describing: error))]")
            }
        }
    }
}

// 카카오 로그인
extension LoginAuth {
    func startKakaoLogin(completion: @escaping (_ succeed: Login?, _ failed: MyError?) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                self.getKakaoUserInfo(oauthToken?.accessToken) { login, error in
                    completion(login, error)
                }
            }
        } else {
            // UserApi.shared.loginWithKakaoAccount(prompts: [.Login]) { oauthToken, error in
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                self.getKakaoUserInfo(oauthToken?.accessToken) { login, error in
                    completion(login, error)
                }
            }
        }
    }

    func getKakaoUserInfo(_ accessToken: String?, completion: @escaping (_ succeed: Login?, _ failed: MyError?) -> Void) {
        UserApi.shared.me { user, error in
            if let email = user?.kakaoAccount?.email, let id = user?.id {
                // let nick = user?.kakaoAccount?.profile?.nickname
                self.snsLogin(userId: email, userPw: String(describing: id), loginMethod: "KAKAO") { login, error in
                    completion(login, error)
                }
            }
        }
    }
}

extension NaverThirdPartyLoginConnection {
    var completion: ((_ succeed: Login?, _ failed: MyError?) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &completionHandlerKey) as? ((_ succeed: Login?, _ failed: MyError?) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &completionHandlerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// 네이버 로그인
extension LoginAuth: NaverThirdPartyLoginConnectionDelegate {
    // 네이버 로그인 실패 시 호출되는 메서드
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)]")
    }

    // 네이버 로그인 창이 닫혔을 때 호출되는 메서드
    func oauth20ConnectionDidFinishDeleteToken() {
        NSLog("[LOG][I]][(\(#fileID):\(#line))::\(#function)]")
    }

    // 에러 발생 시 호출되는 메서드
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)][\(error.localizedDescription)]")
    }

    // 네이버 로그인 성공 시 호출되는 메서드
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        if let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance(), loginInstance.accessToken != nil {
            NSLog("[LOG][W][(\(#fileID):\(#line))::\(#function)][\(String(describing: loginInstance))]")
            self.getNaverUserInfo(loginInstance.tokenType, loginInstance.accessToken) { login, error in
                loginInstance.completion!(login, error)
            }
        }
    }

    func requestNaverLogin() {
        NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)]")
        guard let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return }
        loginInstance.delegate = self
        loginInstance.requestThirdPartyLogin()
    }

    func startNaverLogin(completion: @escaping (_ succeed: Login?, _ failed: MyError?) -> Void) {
        NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)]")
        guard let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return }
        loginInstance.completion = completion
        if loginInstance.isValidAccessTokenExpireTimeNow() {
            self.getNaverUserInfo(loginInstance.tokenType, loginInstance.accessToken) { login, error in
                completion(login, error)
            }
            return
        }
        self.requestNaverLogin()
    }

    func getNaverUserInfo(_ tokenType: String?, _ accessToken: String?, completion: @escaping (_ succeed: Login?, _ failed: MyError?) -> Void) {
        NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)]")
        guard let tokenType = tokenType else { return }
        guard let accessToken = accessToken else { return }

        let urlString = "https://openapi.naver.com/v1/nid/me"
        let session = URLSession.shared
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)

        let authorization = "\(tokenType) \(accessToken)"
        request.addValue(authorization, forHTTPHeaderField: "Authorization")

        session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let responseData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? NSDictionary
                    let rescode = json?.value(forKey: "resultcode") as? String
                    let message = json?.value(forKey: "message") as? String
                    print("[NAVER][로그인][resultcode:\(String(describing: rescode))][message:\(String(describing: message))]")
                    if let response = json?.value(forKey: "response") as? NSDictionary {
                        let email = response.value(forKey: "email") as? String
                        let _id = response.value(forKey: "id") as? String
                        // let nick = response.value(forKey: "nickname") as? String

                        if let email = email, let _id = _id {
                            self.snsLogin(userId: email, userPw: String(describing: _id), loginMethod: "NAVER") { login, error in
                                completion(login, error)
                            }
                        } else {
                            // self.showSimpleAlert(msg: "NAVER 로그인에 문제가 발생했어요 [E]\n\(String(describing: message))")
                        }
                    } else {
                        self.requestNaverLogin()
                    }
                } catch {
                    // self.showSimpleAlert(msg: "NAVER 로그인에 문제가 발생했어요 [N]")
                }
            }
        }).resume()
    }
}

extension ASAuthorizationController {
    var completion: ((_ succeed: Login?, _ failed: MyError?) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &completionHandlerKey) as? ((_ succeed: Login?, _ failed: MyError?) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &completionHandlerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// 애플 로그인
extension LoginAuth: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else {
            return UIWindow()
        }
        return window
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }

        // 처음 애플 로그인 시 이메일은 credential.email 에 들어있다.
        var _email = ""
        if let email = credential.email {
            _email = email
        }
        // 두번째부터는 credential.email은 nil이고, credential.identityToken에 들어있다.
        else {
            // credential.identityToken은 jwt로 되어있고, 해당 토큰을 decode 후 email에 접근해야한다.
            if let tokenString = String(data: credential.identityToken ?? Data(), encoding: .utf8) {
                let email2 = Util.decode(jwtToken: tokenString)["email"] as? String ?? ""
                _email = email2
            }
        }

        // // 처음 애플 로그인 시 이메일은 credential.fullName 에 들어있다.
        // if let fullName = credential.fullName {
        //     // print("이름 : \(fullName.familyName ?? "")\(fullName.givenName ?? "")")
        // }

        // print("userIdentifier : \(credential.user)")
        let user = credential.user

        // let nick = credential.fullName

        self.snsLogin(userId: _email, userPw: user, loginMethod: "APPLE") { login, error in
            controller.completion?(login, error)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // self.showToast(msg: "APPLE 로그인에 문제가 발생했어요")
    }

    func startAppleLogin(completion: @escaping (_ succeed: Login?, _ failed: MyError?) -> Void) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        authorizationController.completion = completion // 클로저 할당
    }
}

// 구글 로그인
extension LoginAuth {
    func startGoogleLogin(completion: @escaping (_ succeed: Login?, _ failed: MyError?) -> Void) {
        NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)]")
        // 출처: https://s-o-h-a.tistory.com/47 [Xcode/iOS] SwiftUI 구글(Google)로그인 구현하고 정보 가져오기
        // rootViewController
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        // 로그인 진행
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            // guard let result = signInResult else { return }
            guard let user = signInResult?.user else { return }
            guard let profile = signInResult?.user.profile else { return }

            let email = profile.email
            guard let id = user.userID else { return }

            self.snsLogin(userId: email, userPw: id, loginMethod: "GOOGLE") { login, error in
                completion(login, error)
            }
        }
    }
}

extension LoginAuth {

    func logout() {
        let request = LogoutRequest()
        MemberAPI.logout(request: request) { response, error in
            let userDef = UserDefaults.standard
            userDef.removeObject(forKey: "accessToken")
            userDef.removeObject(forKey: "refreshToken")
            userDef.synchronize()
            self.isLogin = false
        }
    }
}
