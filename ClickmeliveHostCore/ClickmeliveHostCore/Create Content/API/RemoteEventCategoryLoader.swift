//
//  RemoteEventCategoryLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Foundation
import Combine

public final class RemoteEventCategoryLoader: RemoteClient<[EventCategory]>, EventCategoryLoader {
    public func load() -> AnyPublisher<[EventCategory], Error> {
        let endPoint = EventEndpoints.getCategories
        let urlRequest = endPoint.urlRequest(baseURL: baseURL)
        return loadPublisher(urlRequest: urlRequest, mapper: EventCategoryMapper.map)
    }
}

