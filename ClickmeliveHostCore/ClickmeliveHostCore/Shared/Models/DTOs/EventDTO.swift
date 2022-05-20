//
//  EventDTO.swift
//  ClickmeliveCore
//
//  Created by Can Kaçmaz on 9.04.2022.
//

import Foundation

extension EventDTO {
    func toDomain() -> Event {
        return .init(id: eventId ?? -1,
                     categoryId: categoryId ?? -1,
                     image: image,
                     user: user?.toDomain(),
                     title: title ?? "",
                     description: description,
                     startingDate: startingDate,
                     status: Event.EventStatus.get(status: status),
                     hasSpecialOffer: hasSpecialOffer ?? false,
                     realViewer: realViewer ?? 0,
                     virtualViewer: virtualViewer ?? 0,
                     liveStream: liveStream?.toDomain(),
                     video: video,
                     operationCode: operationCode,
                     followingUser: metadata?.isFollowing ?? false)
    }
}

struct EventDTO: Decodable {
    private let eventId: Int?
    private let categoryId: Int?
    private let image: String?
    private let user: UserDTO?
    private let title: String?
    private let description: String?
    private let startingDate: Date?
    private let status: Int?
    private let hasSpecialOffer: Bool?
    private let realViewer: Int?
    private let virtualViewer: Int?
    private let liveStream: LiveStreamDTO?
    private let video: String?
    private let operationCode: String?
    private let metadata: MetadataDTO?
    
    private struct LiveStreamDTO: Decodable {
        let playbackUrl: String
        let viewers: ViewersDTO?
        let ingestEndpoint: String
        let streamKey: String
        let resolution: String?
        
        func toDomain() -> Event.LiveStream {
            return .init(playbackUrl: playbackUrl,
                         realViewer: viewers?.realViewer ?? 0,
                         virtualViewer: viewers?.virtualViewer ?? 0,
                         ingestEndpoint: ingestEndpoint,
                         streamKey: streamKey,
                         resolution: .get(resolution: resolution))
        }
    }
    
    private struct ViewersDTO: Decodable {
        let realViewer: Int?
        let virtualViewer: Int?
    }
    
    private struct MetadataDTO: Decodable {
        let isFollowing: Bool?
    }
}
