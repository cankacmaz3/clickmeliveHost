//
//  AuthTokenStore.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import KeychainSwift
import ClickmeliveHostCore

public final class AuthTokenStore: TokenStore {
    
    private let keychain = KeychainSwift.init()
    private var accessToken: String { return "accessToken" }
    
    enum TokenError: Error {
        case saveFailed
    }
    
    public func deleteToken() {
        keychain.clear()
    }
    
    public func saveToken(_ token: String) throws {
        guard keychain.set(token, forKey: accessToken) else {
            throw TokenError.saveFailed
        }
    }
    
    public func retrieveToken() -> String? {
        return keychain.get(accessToken)
    }
    
    private func get(forKey: String) -> String? {
        return keychain.get(forKey)
    }
}


