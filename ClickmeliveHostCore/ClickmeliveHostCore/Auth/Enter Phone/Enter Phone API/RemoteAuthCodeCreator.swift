//
//  RemoteAuthCodeCreator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public final class RemoteAuthCodeCreator: AuthCodeCreator {
    
    private let client: HTTPClient
    private let baseURL: URL
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = AuthCodeCreator.Result
    
    public init(client: HTTPClient,
                baseURL: URL) {
        self.client = client
        self.baseURL = baseURL
    }
    
    public func perform(phone: String, completion: @escaping (Result) -> Void) {
        let endpoint = AuthEndpoints.createCode(phone: phone)
        client.execute(with: endpoint.urlRequest(baseURL: baseURL)) { result in
            switch result {
            case let .success((data, response)):
                completion(RemoteAuthCodeCreator.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        guard response.isOK,
            let root = try? JSONDecoder().decode(CreateCodeDTO.self, from: data) else {
                return .failure(Error.invalidData)
        }
        
        return .success(root.toDomain())
    }
}
