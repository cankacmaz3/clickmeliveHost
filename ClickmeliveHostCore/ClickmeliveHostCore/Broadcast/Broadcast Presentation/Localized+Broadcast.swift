//
//  Localized+Broadcast.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 23.04.2022.
//

import Foundation

extension Localized {
    enum Broadcast {
        static var table: String { "Broadcast" }

        static var startBroadcast: String {
            NSLocalizedString(
                "BROADCAST_START",
                tableName: table,
                bundle: bundle,
                comment: "Title for start broadcast")
        }
        
        static var stopBroadcast: String {
            NSLocalizedString(
                "BROADCAST_STOP",
                tableName: table,
                bundle: bundle,
                comment: "Title for stop broadcast")
        }
    }
}

