//
//  ProductEndpoints.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation

enum ProductEndpoints: URLRequestBuilder {
    case all(name: String?, page: Int)
}

extension ProductEndpoints {
    var path: String {
        switch self {
        case .all:
            return "/api/v1/product"
        }
    }
}

extension ProductEndpoints {
    var withHeader: [String: String]? {
        return ["Authorization" : "apiKey 617196fc65dc0778fb59e97660856d1921bef5a092bb4071f3c071704e5ca4cc"]
    }
}

extension ProductEndpoints {
    var parameters: [String: Any]? {
        switch self {
        case .all:
            return [:]
        }
    }
}

extension ProductEndpoints {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .all(let name, let page):
            return [URLQueryItem(name: "name", value: name),
                    URLQueryItem(name: "page", value: "\(page)")]
        }
    }
}

extension ProductEndpoints {
    var method: HTTPMethod {
        switch self {
        case .all:
            return .get
        }
    }
}
