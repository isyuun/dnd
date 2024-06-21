//
//  SignupAuth.swift
//  PetTip
//
//  Created by isyuun on 2024/6/20.
//

import Foundation

class SignupAuth: NSObject, ObservableObject {
    func containsSpecialCharacter(input: String) -> Bool {
        do {
            // 알파벳, 숫자, 한글, 공백이 아닌 문자를 나타내는 정규식 패턴
            let regex = try NSRegularExpression(pattern: "[^A-Za-z0-9ㄱ-힣]+", options: [])
            // 정규식 패턴과 매치되는 문자열이 있는지 확인
            return regex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count)) != nil
        } catch {
            // 정규식 에러 처리
            print("Error creating regex: \(error)")
            return false
        }
    }

    func checkNickName(nicknm: String, completion: @escaping (_ data: HTTPURLResponse?, _ error: MyError?) -> Void) {
        if containsSpecialCharacter(input: nicknm) {
            return
        }

        let request = ChkNcknmRequest(ncknm: nicknm)
        MemberAPI.chkNcknm(request: request) { data, error in
            completion(data, error)
        }
    }
}
