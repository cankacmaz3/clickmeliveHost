//
//  KeychainHelper.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import KeychainSwift

enum KeychainKeys {
    static let accessToken: String = "accessToken"
}

class KeychainHelper {
    
    static var instance: KeychainHelper {
        let instance = KeychainHelper()
        return instance
    }
    
    private let keychain = KeychainSwift()
    
    func get(forKey: String) -> String? {
        return keychain.get(forKey)
    }
    
    private func set(value: String, forKey: String) -> Bool {
        let saved = keychain.set(value, forKey: forKey)
        if saved {
            print("Saved to Keychain")
        }
        
        return saved
    }
    
    func getUserToken() -> String? {
        return get(forKey: KeychainKeys.accessToken) ?? nil
    }
    
    func setUserToken(token: String) -> Bool {
        return set(value: token, forKey: KeychainKeys.accessToken)
    }
    
    func isUserLoggedIn() -> Bool {
        return getUserToken() != nil
    }
    
    func logout() {
        keychain.clear()
    }
}
