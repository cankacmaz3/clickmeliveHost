//
//  LoginDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.05.2022.
//

import Foundation

extension LoginDTO {
    func toDomain() -> Login {
        let user = user?.toDomain()
        return .init(token: token, user: user)
    }
}

public struct LoginDTO: Decodable {
    private let token: String?
    private let user: UserDTO?
}
