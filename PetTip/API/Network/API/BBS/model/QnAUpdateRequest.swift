//
//  QnAUpdateRequest.swift
//  PetTip
//
//  Created by carebiz on 1/13/24.
//

import Foundation

struct QnAUpdateRequest: Encodable {
    let pstSn: Int
    let files: [PhotoDataUp]
    let pstCn: String
    let pstSeCd: String
    let pstTtl: String
}

struct PhotoDataUp: Codable {
    let flmPstnLat: String?
    let filePathNm: String
    let flmPstnLot: String?
    let orgnlAtchFileNm, atchFileNm: String
    let atchFileSz: Int
    let fileExtnNm: String
    let atchFileSn: Int
    let rowState: String
}
