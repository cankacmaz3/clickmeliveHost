//
//  AuthEndpoints.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

enum AuthEndpoints: URLRequestBuilder {
    case createCode(phone: String)
    case verifyCode(verificationCodeId: Int,
                    phone: String,
                    code: String)
}

extension AuthEndpoints {
    var path: String {
        switch self {
        case .createCode:
            return "/api/v1/authorization/code"
        case .verifyCode(let verificationCodeId, _,_):
            return "/api/v1/authorization/code/\(verificationCodeId)/verify"
        }
    }
}

extension AuthEndpoints {
    var withHeader: [String: String]? {
        return ["Authorization" : "apiKey 617196fc65dc0778fb59e97660856d1921bef5a092bb4071f3c071704e5ca4cc"]
    }
}

extension AuthEndpoints {
    var parameters: [String: Any]? {
        switch self {
        case .createCode(let phone):
            return ["phone": phone]
        case .verifyCode(_, let phone, let code):
            return [:]
        }
    }
}

extension AuthEndpoints {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .createCode,
             .verifyCode:
            return []
        }
    }
}

extension AuthEndpoints {
    var method: HTTPMethod {
        switch self {
        case .createCode,
             .verifyCode:
            return .post
        }
    }
}
