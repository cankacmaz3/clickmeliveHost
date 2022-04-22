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
    }
}

