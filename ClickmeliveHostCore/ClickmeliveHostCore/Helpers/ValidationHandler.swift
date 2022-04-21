//
//  ValidationHandler.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//


class ValidationError: Error {
    var message: String
   
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String, errorMessage: String) throws -> String
}

enum ValidatorType {
    case phone
    case code
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .phone: return PhoneValidator()
        case .code: return CodeValidator()
        }
    }
}

struct PhoneValidator: ValidatorConvertible {
    func validated(_ value: String, errorMessage: String) throws -> String {
        let text = value.phoneUnformat()
        guard text.count == 10 else {
            throw ValidationError(errorMessage)
        }
        return text
    }
}

struct CodeValidator: ValidatorConvertible {
    func validated(_ value: String, errorMessage: String) throws -> String {
        guard value.count == 6 else {
            throw ValidationError(errorMessage)
        }
        return value
    }
}

extension String {
    @discardableResult
    func validate(validationType: ValidatorType, errorMessage: String = "Input is not valid") throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self, errorMessage: errorMessage)
    }
}

extension Error {
    func validationError() -> String {
        return (self as! ValidationError).message
    }
}
