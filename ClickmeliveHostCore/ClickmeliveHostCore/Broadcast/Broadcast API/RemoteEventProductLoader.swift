//
//  RemoteProductLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public final class RemoteEventProductLoader: EventProductLoader {
    
    private let client: HTTPClient
    private let baseURL: URL
    private let authenticationTokenHeader: [String: String]
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = EventProductLoader.Result
    
    public init(client: HTTPClient,
                baseURL: URL,
                authenticationTokenHeader: [String: String]) {
        self.client = client
        self.baseURL = baseURL
        self.authenticationTokenHeader = authenticationTokenHeader
    }
    
    public func load(eventId: Int, completion: @escaping (Result) -> Void) {
    
        let endpoint = EventEndpoints.getProducts(eventId: eventId)
                                       
        let authenticatedEndpoint = AuthenticatedURLRequestBuilderDecorator(decoratee: endpoint,
                                                                            authenticationTokenHeader: authenticationTokenHeader)
        
        client.execute(with: authenticatedEndpoint.urlRequest(baseURL: baseURL)) { result in
            switch result {
            case let .success((data, response)):
                completion(RemoteEventProductLoader.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        
        guard response.isOK,
            let root = try? JSONDecoder().decode(ProductResponseDTO.self, from: data) else {
                return .failure(Error.invalidData)
        }
        
        return .success(root.toDomain().products)
    }
}
