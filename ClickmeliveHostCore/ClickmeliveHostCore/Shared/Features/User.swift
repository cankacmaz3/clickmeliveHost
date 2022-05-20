//
//  User.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

public struct User: Encodable {
    public  let id: Int
    public let username: String
    public let image: String?
    public let fullName: String
    public let phone: String
    public let email: String
    public let type: UserType?
    public let followerCount: Int
    public let followingCount: Int
    
    public enum UserType: Int, Encodable {
        case BROADCASTER = 2
        case INFLUENCER = 3
        
        static func get(type: Int?) -> UserType? {
            switch type {
            case 2:
                return .BROADCASTER
            case 3:
                return .INFLUENCER
            default:
                return nil
            }
        }
    }
}

