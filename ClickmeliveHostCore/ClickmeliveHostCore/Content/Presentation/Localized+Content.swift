//
//  Localized+Content.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 7.06.2022.
//

import Foundation

extension Localized {
    enum Content {
        static var table: String { "Content" }

        static var videoNavigationTitle: String {
            NSLocalizedString(
                "VIDEO_CONTENT_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Title for navigation")
        }
        
        static var videoName: String {
            NSLocalizedString(
                "VIDEO_CONTENT_VIDEO_NAME",
                tableName: table,
                bundle: bundle,
                comment: "Title for video name")
        }
        
        static var videoNamePlaceholder: String {
            NSLocalizedString(
                "VIDEO_CONTENT_VIDEO_NAME_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Title for video name placeholder")
        }
        
        static var category: String {
            NSLocalizedString(
                "VIDEO_CONTENT_CATEGORY",
                tableName: table,
                bundle: bundle,
                comment: "Title for category")
        }
        
        static var categoryPlaceholder: String {
            NSLocalizedString(
                "VIDEO_CONTENT_CATEGORY_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Title for category placeholder")
        }
        
        static var livestreamNavigationTitle: String {
            NSLocalizedString(
                "LIVESTREAM_CONTENT_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Title for livestream navigation title")
        }
        
        static var streamTitle: String {
            NSLocalizedString(
                "LIVESTREAM_CONTENT_STREAM_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Title for livestream title")
        }
        
        static var streamTitlePlaceholder: String {
            NSLocalizedString(
                "LIVESTREAM_CONTENT_STREAM_TITLE_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "itle for livestream title placeholder")
        }
        
        static var group: String {
            NSLocalizedString(
                "LIVESTREAM_CONTENT_GROUP",
                tableName: table,
                bundle: bundle,
                comment: "Title for content group")
        }
        
        static var groupPlaceholder: String {
            NSLocalizedString(
                "LIVESTREAM_CONTENT_GROUP_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Title for content group placeholder")
        }
       
        static var tags: String {
            NSLocalizedString(
                "CONTENT_TAGS",
                tableName: table,
                bundle: bundle,
                comment: "Title for tags")
        }
        
        static var tagsPlaceholder: String {
            NSLocalizedString(
                "CONTENT_TAGS_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Title for navigation")
        }
        
        static var addVideos: String {
            NSLocalizedString(
                "CONTENT_ADD_VIDEO",
                tableName: table,
                bundle: bundle,
                comment: "Title for add video")
        }
        
        static var addVideoMessage: String {
            NSLocalizedString(
                "CONTENT_VIDEO_MESSAGE",
                tableName: table,
                bundle: bundle,
                comment: "Title for add video message")
        }
        
        static var coverPhoto: String {
            NSLocalizedString(
                "CONTENT_COVER_PHOTO",
                tableName: table,
                bundle: bundle,
                comment: "Title for cover photo")
        }
        
        static var addPhoto: String {
            NSLocalizedString(
                "CONTENT_ADD_PHOTO",
                tableName: table,
                bundle: bundle,
                comment: "Title for add photo")
        }
        
        static var maxMBAlert: String {
            NSLocalizedString(
                "CONTENT_MAX_MB_ALERT",
                tableName: table,
                bundle: bundle,
                comment: "Title for max mb alert")
        }
        
        static var ratioAlert: String {
            NSLocalizedString(
                "CONTENT_RATIO_ALERT",
                tableName: table,
                bundle: bundle,
                comment: "Title for ratio alert")
        }
        
        static var imageAlert: String {
            NSLocalizedString(
                "CONTENT_IMAGE_ALERT",
                tableName: table,
                bundle: bundle,
                comment: "Title for ratio alert")
        }
        
        static var categorySelect: String {
            NSLocalizedString(
                "CONTENT_CATEGORY_SELECT",
                tableName: table,
                bundle: bundle,
                comment: "Title for category selection button")
        }
        
        static var approve: String {
            NSLocalizedString(
                "CONTENT_APPROVE",
                tableName: table,
                bundle: bundle,
                comment: "Title for approve button")
        }
    }
}
