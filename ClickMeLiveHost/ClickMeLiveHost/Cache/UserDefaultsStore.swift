//
//  UserDefaultsStore.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation
import ClickmeliveHostCore


public final class UserDefaultsStore: DefaultsStore {
    private let defaults: UserDefaults
   
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    public func saveUser(_ user: User) {
        do {
            try defaults.setObject(user, forKey: UserDefaultsKeys.user)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func loadUser() -> User? {
        do {
            let user = try defaults.getObject(forKey: UserDefaultsKeys.user, castTo: UserDTO.self)
            return user.toDomain()
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func deleteUser() {
        defaults.removeObject(forKey: UserDefaultsKeys.user)
    }
}

