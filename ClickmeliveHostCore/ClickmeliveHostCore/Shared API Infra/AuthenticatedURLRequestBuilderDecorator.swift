//
//  AuthenticatedURLRequestBuilderDecorator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

class AuthenticatedURLRequestBuilderDecorator: URLRequestBuilder {
    
    private let authenticationTokenHeader: [String: String]
    
    var path: String
    var parameters: [String : Any]?
    var queryItems: [URLQueryItem]?
    var method: HTTPMethod
    var withHeader: [String : String]?
    
    init(decoratee: URLRequestBuilder,
         authenticationTokenHeader: [String: String]) {
        self.authenticationTokenHeader = authenticationTokenHeader
        
        self.path = decoratee.path
        self.parameters = decoratee.parameters
        self.queryItems = decoratee.queryItems
        self.method = decoratee.method
        
        self.addAuthTokenHeader(decoratee)
    }
    
    private func addAuthTokenHeader(_ decoratee: URLRequestBuilder) {
        var header = decoratee.withHeader
        header?.merge(authenticationTokenHeader) {(first, _) in first}
        self.withHeader = header
    }
}

