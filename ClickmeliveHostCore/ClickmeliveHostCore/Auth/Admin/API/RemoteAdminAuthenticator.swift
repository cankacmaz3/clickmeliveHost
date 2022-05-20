//
//  RemoteAdminAuthenticator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 20.05.2022.
//

import Foundation

public final class RemoteAdminAuthenticator: AdminAuthenticator {
    
    private let client: HTTPClient
    private let baseURL: URL
    
    public typealias Result = AdminAuthenticator.Result
    
    public init(client: HTTPClient,
                baseURL: URL) {
        self.client = client
        self.baseURL = baseURL
    }
    
    public func perform(adminAuthenticationRequest: AdminAuthenticationRequest, completion: @escaping (Result) -> Void) {
        let endpoint = AuthEndpoints.adminLogin(
            email: adminAuthenticationRequest.email,
            password: adminAuthenticationRequest.password)
        
        client.execute(with: endpoint.urlRequest(baseURL: baseURL)) { result in
            switch result {
            case let .success((data, response)):
                completion(RemoteAdminAuthenticator.map(data, from: response))
            case .failure:
                completion(.failure(.init(message: Localized.Error.defaultMessage)))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        guard response.isOK,
            let root = try? JSONDecoder().decode(LoginDTO.self, from: data) else {
               
                guard let serverError = try? JSONDecoder().decode(CMLErrorDTO.self, from: data) else {
                    return .failure(.init(message: Localized.Error.defaultMessage))
                }
                print(serverError)
                return .failure(serverError.toDomain())
        }
        
        return .success(root.toDomain())
    }
}


