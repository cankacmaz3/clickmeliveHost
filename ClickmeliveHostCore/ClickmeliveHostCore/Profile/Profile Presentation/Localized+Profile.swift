//
//  Localized+Profile.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 1.05.2022.
//

import Foundation

extension Localized {
    enum Profile {
        static var table: String { "Profile" }

        static var logout: String {
            NSLocalizedString(
                "PROFILE_LOGOUT",
                tableName: table,
                bundle: bundle,
                comment: "Title for logout")
        }
    }
}
