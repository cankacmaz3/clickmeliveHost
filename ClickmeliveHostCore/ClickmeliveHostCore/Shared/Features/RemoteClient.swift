//
//  RemoteClient.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Combine
import Foundation

public class RemoteClient<Resource> {
    internal let client: HTTPClient
    internal let baseURL: URL
    internal let authTokenLoader: AuthTokenLoader?
   
    public typealias Mapper = (Data, HTTPURLResponse) throws -> Resource
    
    public init(client: HTTPClient,
                baseURL: URL,
                authTokenLoader: AuthTokenLoader? = nil) {
        self.client = client
        self.baseURL = baseURL
        self.authTokenLoader = authTokenLoader
    }
    
    public func loadPublisher(urlRequest: URLRequest, mapper: @escaping Mapper) -> AnyPublisher<Resource, Error> {
        return client
            .getPublisher(urlRequest: urlRequest, withAuthentication: authTokenLoader)
            .dispatchOnMainQueue()
            .tryMap(mapper)
            .mapError(ErrorMapper.map)
            .eraseToAnyPublisher()
    }
}
