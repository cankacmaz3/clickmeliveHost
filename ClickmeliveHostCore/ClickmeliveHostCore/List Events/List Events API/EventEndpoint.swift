//
//  EventEndpoint.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

enum EventEndpoint: URLRequestBuilder {
    case all
}

extension EventEndpoint {
    var path: String {
        switch self {
        case .all:
            return "/api/v1/event"
        }
    }
}

extension EventEndpoint {
    var withHeader: [String: String]? {
        return ["Authorization" : "apiKey 617196fc65dc0778fb59e97660856d1921bef5a092bb4071f3c071704e5ca4cc"]
    }
}

extension EventEndpoint {
    var parameters: [String: Any]? {
        switch self {
        case .all:
            return [:]
        }
    }
}

extension EventEndpoint {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .all:
            return [URLQueryItem(name: "page", value: "1")]
        }
    }
}

extension EventEndpoint {
    var method: HTTPMethod {
        switch self {
        case .all:
            return .get
        }
    }
}


