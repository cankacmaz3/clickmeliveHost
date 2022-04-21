//
//  Localized+EnterPhone.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation

extension Localized {
    enum EnterPhone {
        static var table: String { "EnterPhone" }

        static var title: String {
            NSLocalizedString(
                "ENTER_PHONE_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Enter phone title")
        }
        
        static var detail: String {
            NSLocalizedString(
                "ENTER_PHONE_DETAIL",
                tableName: table,
                bundle: bundle,
                comment: "Enter phone detail")
        }
        
        static var phonePlaceholder: String {
            NSLocalizedString(
                "ENTER_PHONE_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Placeholder for phone textfield")
        }
        
        static var sendCode: String {
            NSLocalizedString(
                "ENTER_PHONE_SEND_CODE",
                tableName: table,
                bundle: bundle,
                comment: "Send code button title")
        }
    }
}
