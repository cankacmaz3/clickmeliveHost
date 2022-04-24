//
//  Event.swift
//  ClickmeliveCore
//
//  Created by Can Kaçmaz on 9.04.2022.
//

import Foundation

public struct Event {
    public let id: Int
    public let categoryId: Int
    public let image: String?
    public let user: User?
    public let title: String
    public let description: String?
    public let startingDate:  Date?
    public let status: EventStatus
    public let hasSpecialOffer: Bool
    public let realViewer: Int
    public let virtualViewer: Int
    public let liveStream: LiveStream?
    public let video: String?
    public let operationCode: String?
    public let followingUser: Bool
    
    public enum EventStatus: Int {
        case CANCELLED = -1
        case UPCOMING = 0
        case LIVE = 1
        case ENDED = 2
        case SHORT_VIDEO = 3
        case LONG_VIDEO = 4
        
        static func get(status: Int?) -> EventStatus {
            switch status {
            case -1:
                return .CANCELLED
            case 0:
                return .UPCOMING
            case 1:
                return .LIVE
            case 2:
                return .ENDED
            case 3:
                return .SHORT_VIDEO
            case 4:
                return .LONG_VIDEO
            default:
                return .LONG_VIDEO
            }
        }
        
        var isVideoEvent: Bool {
            self == .SHORT_VIDEO || self == .LONG_VIDEO
        }
    }
    
    public struct LiveStream {
        public let playbackUrl: String
        public let realViewer: Int
        public let virtualViewer: Int
        public let ingestEndpoint: String
        public let streamKey: String
    }
    
    public var viewerCount: Int {
        if status == .LIVE || status == .UPCOMING {
            return liveStream?.virtualViewer ?? 0
        } else {
            return virtualViewer
        }
    }
    
    public var isViewerCountHidden: Bool {
        viewerCount <= 0
    }
    
    public var merchant: String {
        user?.fullName ?? ""
    }
}
