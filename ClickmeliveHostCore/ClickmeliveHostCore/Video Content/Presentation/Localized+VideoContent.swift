//
//  Localized+VideoContent.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 7.06.2022.
//

import Foundation

extension Localized {
    enum VideoContent {
        static var table: String { "VideoContent" }

        static var navigationTitle: String {
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
        
        static var tags: String {
            NSLocalizedString(
                "VIDEO_CONTENT_TAGS",
                tableName: table,
                bundle: bundle,
                comment: "Title for tags")
        }
        
        static var tagsPlaceholder: String {
            NSLocalizedString(
                "VIDEO_CONTENT_TAGS_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Title for navigation")
        }
        
        static var addVideos: String {
            NSLocalizedString(
                "VIDEO_CONTENT_ADD_VIDEO",
                tableName: table,
                bundle: bundle,
                comment: "Title for add video")
        }
        
        static var addVideoMessage: String {
            NSLocalizedString(
                "VIDEO_CONTENT_VIDEO_MESSAGE",
                tableName: table,
                bundle: bundle,
                comment: "Title for add video message")
        }
        
        static var coverPhoto: String {
            NSLocalizedString(
                "VIDEO_CONTENT_COVER_PHOTO",
                tableName: table,
                bundle: bundle,
                comment: "Title for cover photo")
        }
        
        static var addPhoto: String {
            NSLocalizedString(
                "VIDEO_CONTENT_ADD_PHOTO",
                tableName: table,
                bundle: bundle,
                comment: "Title for add photo")
        }
        
        static var maxMBAlert: String {
            NSLocalizedString(
                "VIDEO_CONTENT_MAX_MB_ALERT",
                tableName: table,
                bundle: bundle,
                comment: "Title for max mb alert")
        }
        
        static var ratioAlert: String {
            NSLocalizedString(
                "VIDEO_CONTENT_RATIO_ALERT",
                tableName: table,
                bundle: bundle,
                comment: "Title for ratio alert")
        }
        
        static var imageAlert: String {
            NSLocalizedString(
                "VIDEO_CONTENT_IMAGE_ALERT",
                tableName: table,
                bundle: bundle,
                comment: "Title for ratio alert")
        }
        
        static var categorySelect: String {
            NSLocalizedString(
                "VIDEO_CONTENT_CATEGORY_SELECT",
                tableName: table,
                bundle: bundle,
                comment: "Title for category selection button")
        }
        
        static var approve: String {
            NSLocalizedString(
                "VIDEO_CONTENT_APPROVE",
                tableName: table,
                bundle: bundle,
                comment: "Title for approve button")
        }
    }
}
