//
//  ValidateCodeViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public final class ValidateCodeViewModel {
    public typealias Observer<T> = (T) -> Void
    
    private let phone: String
    private let verificationCodeId: Int
    private let authCodeValidator: AuthCodeValidator
    
    public init(phone: String,
                verificationCodeId: Int,
                authCodeValidator: AuthCodeValidator) {
        self.phone = phone
        self.verificationCodeId = verificationCodeId
        self.authCodeValidator = authCodeValidator
    }
    
    public var onCodeValidated: Observer<ValidateCode>?
    public var onError: Observer<String>?
    
    public var title: String {
        Localized.ValidateCode.title
    }
    
    public var detail: String {
        Localized.ValidateCode.detail
    }
    
    public var codePlaceholder: String {
        Localized.ValidateCode.codePlaceholder
    }
    
    public var validate: String {
        Localized.ValidateCode.validate
    }
    
    private var errorAlertActionButtonTitle: String {
        Localized.Error.defaultButtonTitle
    }
    
    private var errorUserNotFound: String {
        Localized.Error.userNotFound
    }
    
    public func isValid(code: String) -> Bool {
        do{
            try code.validate(validationType: .code)
            return true
        } catch(let error) {
            print(error.validationError())
            return false
        }
    }
    
    public func validate(code: String) {
        authCodeValidator.perform(validateCodeRequest: .init(phone: phone,
                                                             code: code,
                                                             verificationCodeId: verificationCodeId)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(validateCode):
                validateCode.isMember == true ?
                self.onCodeValidated?(validateCode) :
                self.onError?(self.errorUserNotFound)
            case let .failure(error):
                self.onError?(error.message)
            }
        }
    }
}
