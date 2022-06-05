//
//  Localized+CreateContent.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation

extension Localized {
    enum CreateContent {
        static var table: String { "CreateContent" }

        static var navigationTitle: String {
            NSLocalizedString(
                "CREATE_CONTENT_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Title for navigation")
        }
        
        static var livestream: String {
            NSLocalizedString(
                "CREATE_CONTENT_LIVESTREAM",
                tableName: table,
                bundle: bundle,
                comment: "Title for livestream")
        }
        
        static var video: String {
            NSLocalizedString(
                "CREATE_CONTENT_VIDEO",
                tableName: table,
                bundle: bundle,
                comment: "Title for video")
        }
    }
}
