//
//  EventEndpoint.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

enum EventEndpoints: URLRequestBuilder {
    case statusEvents(status: [Event.EventStatus], page: Int)
    case getProducts(eventId: Int)
    case updateStatus(eventId: Int, status: Event.EventStatus)
    case deleteEvent(eventId: Int)
    case getCategories
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
        case .deleteEvent(let eventId):
            return "/api/v1/event/\(eventId)"
        case .getCategories:
            return "/api/v1/event/category"
        }
    }
}

extension EventEndpoints {
    var withHeader: [String: String]? {
        switch self {
        case .updateStatus:
            return ["Authorization" : "apiKey 2fb28e53a8f34f7edd0954796c47ec2ea1b5677abdb46b6020974494a47ee29c"]
        default:
            return ["Authorization" : "apiKey 617196fc65dc0778fb59e97660856d1921bef5a092bb4071f3c071704e5ca4cc"]
        }
        
    }
}

extension EventEndpoints {
    var parameters: [String: Any]? {
        switch self {
        case .statusEvents,
             .getProducts,
             .deleteEvent,
             .getCategories:
            return [:]
        case .updateStatus(_, let status):
            return ["status": status.rawValue]
        }
    }
}

extension EventEndpoints {
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .statusEvents(statuses, page):
            var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
            
            statuses.forEach { status in
                queryItems.append(URLQueryItem(name: "status[]", value: "\(status.rawValue)"))
                
                if status == .UPCOMING {
                    queryItems.append(URLQueryItem(name: "status[]", value: "\(Event.EventStatus.LIVE.rawValue)"))
                }
            }
            
            return queryItems
        case .getProducts:
            return [URLQueryItem(name: "page", value: "\(1)")]
        case .getCategories:
            return [URLQueryItem(name: "isActive", value: "true")]
        case .updateStatus,
             .deleteEvent:
            return []
        }
    }
}

extension EventEndpoints {
    var method: HTTPMethod {
        switch self {
        case .statusEvents,
             .getProducts,
             .getCategories:
            return .get
        case .updateStatus:
            return .patch
        case .deleteEvent:
            return .delete
        }
    }
}


