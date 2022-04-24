//
//  EventEndpoint.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

enum EventEndpoints: URLRequestBuilder {
    case statusEvents(status: Event.EventStatus, page: Int)
    case getProducts(eventId: Int)
    case updateStatus(eventId: Int, status: Event.EventStatus)
}

extension EventEndpoints {
    var path: String {
        switch self {
        case .statusEvents:
            return "/api/v1/event"
        case let .getProducts(eventId):
            return "/api/v1/event/\(eventId)/product"
        case .updateStatus(let eventId, _):
            return "/api/v1/event/\(eventId)/status"
        }
    }
}

extension EventEndpoints {
    var withHeader: [String: String]? {
        switch self {
        case .statusEvents,
             .getProducts:
            return ["Authorization" : "apiKey 617196fc65dc0778fb59e97660856d1921bef5a092bb4071f3c071704e5ca4cc"]
        case .updateStatus:
            return ["Authorization" : "apiKey 2fb28e53a8f34f7edd0954796c47ec2ea1b5677abdb46b6020974494a47ee29c"]
        }
        
    }
}

extension EventEndpoints {
    var parameters: [String: Any]? {
        switch self {
        case .statusEvents,
             .getProducts:
            return [:]
        case .updateStatus(_, let status):
            return ["status": status.rawValue]
        }
    }
}

extension EventEndpoints {
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .statusEvents(status, page):
            return [URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "status", value: "\(status.rawValue)")]
        case .getProducts:
            return [URLQueryItem(name: "page", value: "\(1)")]
        case .updateStatus:
            return []
        }
    }
}

extension EventEndpoints {
    var method: HTTPMethod {
        switch self {
        case .statusEvents,
             .getProducts:
            return .get
        case .updateStatus:
            return .patch
        }
    }
}


