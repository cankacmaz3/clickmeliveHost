//
//  ValidateCodeRequest.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public struct ValidateCodeRequest {
    let phone: String
    let code: String
    let verificationCodeId: Int
}
