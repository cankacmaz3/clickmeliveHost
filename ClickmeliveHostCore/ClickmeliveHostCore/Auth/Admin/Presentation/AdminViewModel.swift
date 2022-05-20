//
//  AdminViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 20.05.2022.
//

import Foundation

public final class AdminViewModel {
    public typealias Observer<T> = (T) -> Void
    
    private let adminAuthenticator: AdminAuthenticator
    
    public init(adminAuthenticator: AdminAuthenticator) {
        self.adminAuthenticator = adminAuthenticator
    }
    
    public var onLogin: Observer<Login>?
    public var onError: Observer<String>?
    
    public var title: String {
        Localized.AdminLogin.title
    }
    
    public var emailPlaceholder: String {
        Localized.AdminLogin.emailPlaceholder
    }
    
    public var passwordPlaceholder: String {
        Localized.AdminLogin.passwordPlaceholder
    }
    
    public var login: String {
        Localized.AdminLogin.login
    }
    
    public var useSMS: String {
        Localized.AdminLogin.useSMS
    }
    
    private var errorAlertActionButtonTitle: String {
        Localized.Error.defaultButtonTitle
    }
    
    private var errorUserNotFound: String {
        Localized.Error.userNotFound
    }
    
    public func isValid(email: String, password: String) -> Bool {
        do{
            try email.validate(validationType: .email)
            return true
        } catch(let error) {
            print(error.validationError())
            return false
        }
    }
    
    public func login(email: String, password: String) {
        adminAuthenticator.perform(adminAuthenticationRequest: .init(
            email: email,
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


