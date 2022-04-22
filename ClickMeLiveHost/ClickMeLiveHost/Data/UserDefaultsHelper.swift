//
//  UserDefaultsHelper.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import ClickmeliveHostCore

enum UserDefaultsKeys {
    static let user: String = "user"
}

class ClickMeUserDefaults {
    
    private let defaults: UserDefaults
   
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    var isItFirstLaunch: Bool {
        get {
            return defaults[#function] ?? true
        }
        set {
            defaults[#function] = newValue
        }
    }
}

extension UserDefaults {
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set {
            set(newValue?.rawValue, forKey: key)
        }
    }
}
