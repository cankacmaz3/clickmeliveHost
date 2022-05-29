//
//  Localized+Alert.swift
//  Clickmelive
//
//  Created by Can Kaçmaz on 23.05.2022.
//

import Foundation

extension Localized {
    enum Alert {
        static var table: String { "Alert" }

        static var defaultActionButtonTitle: String {
            NSLocalizedString(
                "ALERT_DEFAULT_ACTION_BUTTON_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Title for action button")
        }
    }
}


