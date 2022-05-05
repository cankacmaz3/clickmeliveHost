//
//  Localized+UsePassword.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.05.2022.
//

import Foundation

extension Localized {
    enum UsePassword {
        static var table: String { "UsePassword" }

        static var title: String {
            NSLocalizedString(
                "USE_PASSWORD_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Use password title")
        }
        
        static var phonePlaceholder: String {
            NSLocalizedString(
                "USE_PASSWORD_PHONE_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Placeholder for phone textfield")
        }
        
        static var passwordPlaceholder: String {
            NSLocalizedString(
                "USE_PASSWORD_PASSWORD_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Placeholder for password textfield")
        }
        
        static var login: String {
            NSLocalizedString(
                "USE_PASSWORD_LOGIN",
                tableName: table,
                bundle: bundle,
                comment: "login button title")
        }
        
        static var useSMS: String {
            NSLocalizedString(
                "USE_PASSWORD_USE_SMS",
                tableName: table,
                bundle: bundle,
                comment: "Use sms button title")
        }
    }
}

