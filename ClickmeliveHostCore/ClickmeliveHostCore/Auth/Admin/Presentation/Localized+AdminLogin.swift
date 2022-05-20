//
//  Localized+AdminLogin.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 20.05.2022.
//

import Foundation

extension Localized {
    enum AdminLogin {
        static var table: String { "AdminLogin" }

        static var title: String {
            NSLocalizedString(
                "ADMIN_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Use password title")
        }
        
        static var emailPlaceholder: String {
            NSLocalizedString(
                "ADMIN_EMAIL_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Placeholder for email textfield")
        }
        
        static var passwordPlaceholder: String {
            NSLocalizedString(
                "ADMIN_PASSWORD_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Placeholder for password textfield")
        }
        
        static var login: String {
            NSLocalizedString(
                "ADMIN_LOGIN",
                tableName: table,
                bundle: bundle,
                comment: "login button title")
        }
        
        static var useSMS: String {
            NSLocalizedString(
                "ADMIN_USE_SMS",
                tableName: table,
                bundle: bundle,
                comment: "Use sms button title")
        }
    }
}

