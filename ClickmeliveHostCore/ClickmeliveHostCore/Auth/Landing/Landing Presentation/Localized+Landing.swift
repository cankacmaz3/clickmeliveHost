//
//  Localized+Landing.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation

extension Localized {
    enum Landing {
        static var table: String { "Landing" }

        static var loginButton: String {
            NSLocalizedString(
                "LANDING_LOGIN_BUTTON_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Title for login button")
        }
    }
}


