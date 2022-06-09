//
//  RemoteEventCreator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Foundation
import Combine

public final class RemoteEventCreator: RemoteClient<Event>, EventCreator {
    public func createVideo(isActive: Bool, status: Event.EventStatus, title: String, categoryId: Int, image: String, video: String, products: [Int], tags: [String]) -> AnyPublisher<Event, Error> {
        let endPoint = EventEndpoints.createVideo(isActive: isActive, status: status, title: title, categoryId: categoryId, image: image, video: video, products: products, tags: tags)
        let urlRequest = endPoint.urlRequest(baseURL: baseURL)
        return loadPublisher(urlRequest: urlRequest, mapper: EventMapper.map)
    }
}
