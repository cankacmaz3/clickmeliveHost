//
//  Localized+ValidateCode.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

extension Localized {
    enum ValidateCode {
        static var table: String { "ValidateCode" }

        static var title: String {
            NSLocalizedString(
                "VALIDATE_CODE_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Validate phone title")
        }
        
        static var detail: String {
            NSLocalizedString(
                "VALIDATE_CODE_DETAIL",
                tableName: table,
                bundle: bundle,
                comment: "Validate phone detail")
        }
        
        static var codePlaceholder: String {
            NSLocalizedString(
                "VALIDATE_CODE_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Placeholder for code textfield")
        }
        
        static var validate: String {
            NSLocalizedString(
                "VALIDATE_CODE_VALIDATE",
                tableName: table,
                bundle: bundle,
                comment: "Validate code button title")
        }
    }
}

