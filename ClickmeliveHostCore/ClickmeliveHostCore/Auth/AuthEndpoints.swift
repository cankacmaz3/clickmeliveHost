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
    case login(phone: String,
               password: String)
}

extension AuthEndpoints {
    var path: String {
        switch self {
        case .createCode:
            return "/api/v1/authorization/code"
        case .verifyCode(let verificationCodeId, _,_):
            return "/api/v1/authorization/code/\(verificationCodeId)/verify"
        case .login:
            return "/api/v1/authorization/login"
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
        let deviceInfo = DeviceHelper.getDeviceInfo()
       
        switch self {
        case .createCode(let phone):
            return ["phone": phone]
        case .verifyCode(_, let phone, let code):
            
            return ["phone": phone,
                    "code": code,
                    "deviceInfo": [
                        "deviceBrand": deviceInfo.deviceBrand,
                        "deviceModel": deviceInfo.deviceModel,
                        "osVersion": deviceInfo.osVersion,
                        "appVersion": deviceInfo.appVersion,
                        "uniqueToken": deviceInfo.uniqueToken
                    ]]
        case .login(let phone, let password):
            return ["phone": phone,
                    "password": password,
                    "deviceInfo": [
                        "deviceBrand": deviceInfo.deviceBrand,
                         "deviceModel": deviceInfo.deviceModel,
                         "osVersion": deviceInfo.osVersion,
                         "appVersion": deviceInfo.appVersion,
                         "uniqueToken": deviceInfo.uniqueToken
                     ]]
        }
    }
}

extension AuthEndpoints {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .createCode,
             .verifyCode,
             .login:
            return []
        }
    }
}

extension AuthEndpoints {
    var method: HTTPMethod {
        switch self {
        case .createCode,
             .verifyCode,
             .login:
            return .post
        }
    }
}
