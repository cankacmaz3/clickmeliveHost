//
//  ValidateCodeDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

extension ValidateCodeDTO {
    func toDomain() -> ValidateCode {
        let user = user?.toDomain()
        return .init(isMember: registrationRequired == false, token: token, user: user)
    }
}

struct ValidateCodeDTO: Decodable {
    let registrationRequired: Bool
    let token: String?
    let user: UserDTO?
}
