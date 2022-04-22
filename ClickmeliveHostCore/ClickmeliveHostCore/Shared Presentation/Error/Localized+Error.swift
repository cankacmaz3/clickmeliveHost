//
//  Localized+Error.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

extension Localized {
    enum Error {
        static var table: String { "Error" }

        static var defaultMessage: String {
            NSLocalizedString(
                "ERROR_DEFAULT_MESSAGE",
                tableName: table,
                bundle: bundle,
                comment: "Default error message")
        }
        
        static var defaultButtonTitle: String {
            NSLocalizedString(
                "ERROR_DEFAULT_BUTTON_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Default error alert button title")
        }
        
        static var verificationCodeNotFound: String {
            NSLocalizedString(
                "INVALID_VERIFICATION_CODE",
                tableName: table,
                bundle: bundle,
                comment: "Default error alert button title")
        }
        
        static var userNotFound: String {
            NSLocalizedString(
                "USER_NOT_FOUND",
                tableName: table,
                bundle: bundle,
                comment: "Error message")
        }
    }
}

extension String {
    func showLocalizedErrorMessage() -> String {
        var message = Localized.Error.defaultMessage
        let localizedCode = NSLocalizedString(self,
                                              tableName: Localized.Error.table,
                                              bundle: Bundle(for: Localized.self),
                                              comment: "")
        
        if !localizedCode.elementsEqual(self) {
            message = localizedCode
        }
        return message
    }
}
