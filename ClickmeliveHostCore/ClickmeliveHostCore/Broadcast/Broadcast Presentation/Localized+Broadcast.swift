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
        
        static var soundTitle: String {
            NSLocalizedString(
                "BROADCAST_SOUND",
                tableName: table,
                bundle: bundle,
                comment: "Title for sound")
        }
        
        static var rotateTitle: String {
            NSLocalizedString(
                "BROADCAST_ROTATE",
                tableName: table,
                bundle: bundle,
                comment: "Title for rotate")
        }
        
        static var cameraTitle: String {
            NSLocalizedString(
                "BROADCAST_CAMERA",
                tableName: table,
                bundle: bundle,
                comment: "Title for camera")
        }
        
        static var startingDateErrorMessage: String {
            NSLocalizedString(
                "BROADCAST_STARTING_DATE_ERROR",
                tableName: table,
                bundle: bundle,
                comment: "Title for starting date error message")
        }
    }
}
