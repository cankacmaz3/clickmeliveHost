//
//  RemoteEventLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

public final class RemoteEventLoader: EventLoader {
    
    private let client: HTTPClient
    private let baseURL: URL
    private let authenticationTokenHeader: [String: String]
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias EventResult = EventLoader.Result
    
    public init(client: HTTPClient,
                baseURL: URL,
                authenticationTokenHeader: [String: String]) {
        self.client = client
        self.baseURL = baseURL
        self.authenticationTokenHeader = authenticationTokenHeader
    }
    
    public func load(with status: Event.EventStatus, page: Int, completion: @escaping (EventResult) -> Void) {
        let endpoint = EventEndpoints.statusEvents(status: status, page: page)
                                       
        let authenticatedEndpoint = AuthenticatedURLRequestBuilderDecorator(decoratee: endpoint,
                                                                            authenticationTokenHeader: authenticationTokenHeader)
        
        client.execute(with: authenticatedEndpoint.urlRequest(baseURL: baseURL)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success((data, response)):
                completion(self.map(data, from: response, status: status, page: page))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse, status: Event.EventStatus, page: Int) -> EventResult {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMddTHHmmssSSSZ)
        
        guard response.isOK,
            let root = try? decoder.decode(EventResponseDTO.self, from: data) else {
                return .failure(Error.invalidData)
        }
        
        let next = { (completion: @escaping (EventResult) -> Void) in
            self.load(with: status, page: page + 1, completion: completion)
        }
        
        let paginated = Paginated.node(root.toDomain(), next)
        return .success(paginated)
        
    }
}
