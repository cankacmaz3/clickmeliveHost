//
//  CreateCodeDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

extension CreateCodeDTO {
    func toDomain() -> CreateCode {
        return .init(id: verificationCodeId,
                          phone: phone)
    }
}

public struct CreateCodeDTO: Decodable {
    private let verificationCodeId: Int
    private let phone: String
}
