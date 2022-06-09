//
//  RemoteEventGroupLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Foundation
import Combine

public final class RemoteEventGroupLoader: RemoteClient<[EventGroup]>, EventGroupLoader {
    public func load() -> AnyPublisher<[EventGroup], Error> {
        let endPoint = EventEndpoints.getGroups
        let urlRequest = endPoint.urlRequest(baseURL: baseURL)
        return loadPublisher(urlRequest: urlRequest, mapper: EventGroupMapper.map)
    }
}

