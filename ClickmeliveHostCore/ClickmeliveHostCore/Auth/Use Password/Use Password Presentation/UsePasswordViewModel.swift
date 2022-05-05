//
//  UsePasswordViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.05.2022.
//

import Foundation

public final class UsePasswordViewModel {
    public typealias Observer<T> = (T) -> Void
    
    private let passwordAuthenticator: PasswordAutheticator
    
    public init(passwordAuthenticator: PasswordAutheticator) {
        self.passwordAuthenticator = passwordAuthenticator
    }
    
    public var onLogin: Observer<Login>?
    public var onError: Observer<String>?
    
    public var title: String {
        Localized.UsePassword.title
    }
    
    public var phonePlaceholder: String {
        Localized.UsePassword.phonePlaceholder
    }
    
    public var passwordPlaceholder: String {
        Localized.UsePassword.passwordPlaceholder
    }
    
    public var login: String {
        Localized.UsePassword.login
    }
    
    public var useSMS: String {
        Localized.UsePassword.useSMS
    }
    
    private var errorAlertActionButtonTitle: String {
        Localized.Error.defaultButtonTitle
    }
    
    private var errorUserNotFound: String {
        Localized.Error.userNotFound
    }
    
    public func formatPhone(_ phone: String) -> String {
        return phone.phoneFormat()
    }
    
    public func isValid(phone: String, password: String) -> Bool {
        do{
            try phone.validate(validationType: .phone)
            try password.validate(validationType: .code)
            return true
        } catch(let error) {
            print(error.validationError())
            return false
        }
    }
    
    public func login(phone: String, password: String) {
        passwordAuthenticator.perform(passwordAuthenticationRequest: .init(phone: phone.phoneUnformat(),
                                                                           password: password),
                                      completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(login):
                self.onLogin?(login)
            case .failure:
                self.onError?(self.errorUserNotFound)
            }
        })
    }
}

