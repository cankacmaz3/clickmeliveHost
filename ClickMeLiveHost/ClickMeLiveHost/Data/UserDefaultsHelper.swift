//
//  UserDefaultsHelper.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import ClickmeliveHostCore

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

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
    
    func saveLoggedInUser(user: User?) {
        do {
            try defaults.setObject(user, forKey: UserDefaultsKeys.user)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getLoggedInUser() -> User? {
        do {
            let user = try defaults.getObject(forKey: UserDefaultsKeys.user, castTo: UserDTO.self)
            return user.toDomain()
        } catch {
            print(error.localizedDescription)
            return nil
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
    
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
        
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}
