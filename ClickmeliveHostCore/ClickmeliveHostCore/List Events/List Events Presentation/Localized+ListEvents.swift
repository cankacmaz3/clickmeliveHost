//
//  Localized+ListEvents.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 23.04.2022.
//

import Foundation

extension Localized {
    enum ListEvents {
        static var table: String { "ListEvents" }

        static var statusUpcoming: String {
            NSLocalizedString(
                "LIST_EVENT_STATUS_UPCOMING",
                tableName: table,
                bundle: bundle,
                comment: "Upcoming status title")
        }
        
        static var statusEnded: String {
            NSLocalizedString(
                "LIST_EVENT_STATUS_ENDED",
                tableName: table,
                bundle: bundle,
                comment: "Ended status title")
        }
        
        static var statusCancelled: String {
            NSLocalizedString(
                "LIST_EVENT_STATUS_CANCELLED",
                tableName: table,
                bundle: bundle,
                comment: "Cancelled status title")
        }
    }
}

