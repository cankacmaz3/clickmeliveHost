//
//  RemoteEventLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

public final class RemoteEventLoader: EventLoader {
    
    private let client: HTTPClient
    private let authenticationTokenHeader: [String: String]
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias EventResult = EventLoader.Result
    
    public init(client: HTTPClient,
                authenticationTokenHeader: [String: String]) {
        self.client = client
        self.authenticationTokenHeader = authenticationTokenHeader
    }
    
    public func load(completion: @escaping (EventResult) -> Void) {
        let endpoint = EventEndpoint.all
        let authenticatedEndpoint = AuthenticatedURLRequestBuilderDecorator(decoratee: endpoint,
                                                                            authenticationTokenHeader: authenticationTokenHeader)
        
        client.execute(with: authenticatedEndpoint.urlRequest) { result in
            switch result {
            case let .success((data, response)):
                completion(RemoteEventLoader.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> EventResult {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMddTHHmmssSSSZ)
        
        guard response.isOK,
            let root = try? decoder.decode(EventResponse.self, from: data) else {
                return .failure(Error.invalidData)
        }
        
        let events = root.events?.map { $0.toDomain() } ?? []
        return .success(events)
    }
}
