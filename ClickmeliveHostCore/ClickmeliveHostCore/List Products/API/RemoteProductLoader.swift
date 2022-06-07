//
//  RemoteProductLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation

public final class RemoteProductLoader: ProductLoader {
    
    private let client: HTTPClient
    private let baseURL: URL
    private let authenticationTokenHeader: [String: String]
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = ProductLoader.Result
    
    public init(client: HTTPClient,
                baseURL: URL,
                authenticationTokenHeader: [String: String]) {
        self.client = client
        self.baseURL = baseURL
        self.authenticationTokenHeader = authenticationTokenHeader
    }
    
    public func load(name: String?, page: Int, completion: @escaping (Result) -> Void) {
        let endpoint = ProductEndpoints.all(name: name, page: page)
                                       
        let authenticatedEndpoint = AuthenticatedURLRequestBuilderDecorator(decoratee: endpoint,
                                                                            authenticationTokenHeader: authenticationTokenHeader)
        
        client.execute(with: authenticatedEndpoint.urlRequest(baseURL: baseURL)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success((data, response)):
                completion(self.map(data, from: response, name: name, page: page))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse, name: String?, page: Int) -> Result {
        let decoder = JSONDecoder()
        
        guard response.isOK,
            let root = try? decoder.decode(ProductResponseDTO.self, from: data) else {
                return .failure(Error.invalidData)
        }
        
        let next = { (completion: @escaping (Result) -> Void) in
            self.load(name: name, page: page + 1, completion: completion)
        }
        
        let paginated = Paginated.node(root.toDomain(), next)
        return .success(paginated)
        
    }
}
