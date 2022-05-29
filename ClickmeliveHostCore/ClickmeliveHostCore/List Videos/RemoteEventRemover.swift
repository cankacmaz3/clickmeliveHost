//
//  RemoteEventRemover.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation
import Combine

public final class RemoteEventRemover: RemoteClient<Void>, EventRemover {
    public func remove(eventId: Int) -> AnyPublisher<Void, Error> {
        let endPoint = EventEndpoints.deleteEvent(eventId: eventId)
        let urlRequest = endPoint.urlRequest(baseURL: baseURL)
        return loadPublisher(urlRequest: urlRequest, mapper: EventRemoveMapper.map)
    }
}
