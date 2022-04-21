//
//  EnterPhoneViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation

public final class EnterPhoneViewModel {
    public typealias Observer<T> = (T) -> Void
    
    private let authCodeCreator: AuthCodeCreator
    
    public init(authCodeCreator: AuthCodeCreator) {
        self.authCodeCreator = authCodeCreator
    }
    
    public var onCodeCreated: Observer<CreateCode>?
    public var onError: (() -> Void)?
    
    public var title: String {
        Localized.EnterPhone.title
    }
    
    public var detail: String {
        Localized.EnterPhone.detail
    }
    
    public var phonePlaceholder: String {
        Localized.EnterPhone.phonePlaceholder
    }
    
    public var sendCode: String {
        Localized.EnterPhone.sendCode
    }
    
    public func formatPhone(_ phone: String) -> String {
        return phone.phoneFormat()
    }
    
    public func isValid(phone: String) -> Bool {
        do{
            try phone.validate(validationType: .phone)
            return true
        } catch(let error) {
            print(error.validationError())
            return false
        }
    }
    
    public func sendCode(to phone: String) {
        authCodeCreator.perform(phone: phone.phoneUnformat()) { [weak self] result in
            switch result {
            case let .success(createdCode):
                self?.onCodeCreated?(createdCode)
            case .failure:
                print("failure")
            }
        }
    }
}
