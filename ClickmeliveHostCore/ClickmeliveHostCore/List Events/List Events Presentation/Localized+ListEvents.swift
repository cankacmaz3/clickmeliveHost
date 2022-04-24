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

        static var categoryStatusUpcoming: String {
            NSLocalizedString(
                "LIST_EVENT_CATEGORY_STATUS_UPCOMING",
                tableName: table,
                bundle: bundle,
                comment: "Upcoming status title")
        }
        
        static var categoryStatusEnded: String {
            NSLocalizedString(
                "LIST_EVENT_CATEGORY_STATUS_ENDED",
                tableName: table,
                bundle: bundle,
                comment: "Ended status title")
        }
        
        static var categoryStatusCancelled: String {
            NSLocalizedString(
                "LIST_EVENT_CATEGORY_STATUS_CANCELLED",
                tableName: table,
                bundle: bundle,
                comment: "Cancelled status title")
        }
        
        static var placeholderUpcoming: String {
            NSLocalizedString(
                "LIST_EVENT_PLACEHOLDER_UPCOMING",
                tableName: table,
                bundle: bundle,
                comment: "Placeholder text for upcoming status")
        }
        
        static var placeholderEnded: String {
            NSLocalizedString(
                "LIST_EVENT_PLACEHOLDER_ENDED",
                tableName: table,
                bundle: bundle,
                comment: "Placeholder text for ended status")
        }
        
        static var placeholderCancelled: String {
            NSLocalizedString(
                "LIST_EVENT_PLACEHOLDER_CANCELLED",
                tableName: table,
                bundle: bundle,
                comment: "Placeholder text for cancelled status")
        }
        
        static var statusStartBroadcast: String {
            NSLocalizedString(
                "LIST_EVENT_STATUS_START_BROADCAST",
                tableName: table,
                bundle: bundle,
                comment: "Text for start broadcast status")
        }
        
        static var statusSoon: String {
            NSLocalizedString(
                "LIST_EVENT_STATUS_SOON",
                tableName: table,
                bundle: bundle,
                comment: "Text for soon status")
        }
        
        static var statusApproved: String {
            NSLocalizedString(
                "LIST_EVENT_STATUS_APPROVED",
                tableName: table,
                bundle: bundle,
                comment: "Text for approved status")
        }
        
        static var statusCancelled: String {
            NSLocalizedString(
                "LIST_EVENT_STATUS_CANCELLED",
                tableName: table,
                bundle: bundle,
                comment: "Text for cancelled status")
        }
        
        static var statusEnded: String {
            NSLocalizedString(
                "LIST_EVENT_STATUS_ENDED",
                tableName: table,
                bundle: bundle,
                comment: "Text for ended status")
        }
    }
}
