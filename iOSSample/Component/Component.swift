//
//  Component.swift
//  SwiftSample
//
//  Created by HongInJun on 2021/04/24.
//

import UIKit

struct NaverPapagoApi {
    static let url = "https://openapi.naver.com/v1/papago/n2mt"
    static let clientID = "5R1BBA1dJwF5l0Rj6sXh"
    static let clientSecret = "aeQY58dEF7"
    
    static let naverID = "X-Naver-Client-Id"
    static let naverSecret = "X-Naver-Client-Secret"
}


//enumutation(열거형): 나만의 타입을 만듬
enum NaverPapagoApiStatusCode : Int {
    case success = 200
    case fail = 400
}
