//
//  EventEndpoint.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

enum EventEndpoints: URLRequestBuilder {
    case statusEvents(status: Event.EventStatus, page: Int)
}

extension EventEndpoints {
    var path: String {
        switch self {
        case .statusEvents:
            return "/api/v1/event"
        }
    }
}

extension EventEndpoints {
    var withHeader: [String: String]? {
        return ["Authorization" : "apiKey 617196fc65dc0778fb59e97660856d1921bef5a092bb4071f3c071704e5ca4cc"]
    }
}

extension EventEndpoints {
    var parameters: [String: Any]? {
        switch self {
        case .statusEvents:
            return [:]
        }
    }
}

extension EventEndpoints {
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .statusEvents(status, page):
            return [URLQueryItem(name: "page", value: "\(page)")]//,
//                    URLQueryItem(name: "status", value: "\(status.rawValue)")]
        }
    }
}

extension EventEndpoints {
    var method: HTTPMethod {
        switch self {
        case .statusEvents:
            return .get
        }
    }
}


