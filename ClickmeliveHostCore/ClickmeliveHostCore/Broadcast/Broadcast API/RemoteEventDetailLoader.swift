//
//  RemoteEventDetailLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import Foundation

public final class RemoteEventDetailLoader: EventDetailLoader {
    
    private let client: HTTPClient
    private let baseURL: URL
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = EventDetailLoader.Result
    
    public init(client: HTTPClient,
                baseURL: URL) {
        self.client = client
        self.baseURL = baseURL
    }
    
    public func perform(eventId: Int, status: Event.EventStatus, completion: @escaping (Result) -> Void) {
    
        let endpoint = EventEndpoints.updateStatus(eventId: eventId, status: status)
                                       
        client.execute(with: endpoint.urlRequest(baseURL: baseURL)) { result in
            switch result {
            case let .success((data, response)):
                completion(RemoteEventDetailLoader.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMddTHHmmssSSSZ)
        
        guard response.isOK,
            let root = try? decoder.decode(EventDTO.self, from: data) else {
                return .failure(Error.invalidData)
        }
        
        return .success(root.toDomain())
    }
}

