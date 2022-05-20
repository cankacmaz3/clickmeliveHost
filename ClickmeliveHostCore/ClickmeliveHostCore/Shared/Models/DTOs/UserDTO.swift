//
//  UserDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

extension UserDTO {
    public func toDomain() -> User {
        return .init(id: userId ?? -1,
                     username: username ?? "",
                     image: image,
                     fullName: fullName ?? "",
                     phone: phone ?? "",
                     email: email ?? "",
                     type: User.UserType.get(type: type),
                     followerCount: followers ?? 0,
                     followingCount: following ?? 0)
    }
}

public struct UserDTO: Decodable {
    private let userId: Int?
    private let username: String?
    private let image: String?
    private let fullName: String?
    private let phone: String?
    private let email: String?
    private let type: Int?
    private let followers: Int?
    private let following: Int?
}
