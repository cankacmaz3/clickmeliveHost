//
//  URLRequestBuilder.swift
//  ClickmeliveCore
//
//  Created by Can Kaçmaz on 15.04.2022.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    case put = "PUT"
}

public protocol URLRequestBuilder {
    var path: String { get }
    var parameters: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
    var withHeader: [String: String]? { get }
}

extension URLRequestBuilder {
    
    private var version: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    private var clientDevice: String {
        return "IOS"
    }
    
    private var contentType: String {
        return "application/json"
    }
    
    func urlRequest(baseURL: URL) -> URLRequest {
        var urlComponents = URLComponents(string: baseURL.absoluteString)
        urlComponents?.path = path
        if let queryItems = queryItems {
            if(queryItems.count > 0){
                urlComponents?.queryItems = queryItems
            }
        }
        
        guard let requestURL = urlComponents?.url else {
            fatalError("URL could not be built")
        }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = method.rawValue
        request.setValue("1.0.17", forHTTPHeaderField: "Client-Version")
        request.setValue(clientDevice, forHTTPHeaderField: "Client-Device")
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        if let withHeader = withHeader {
            withHeader.forEach {
                request.addValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        
        if let parameters = parameters {
            if(parameters.count > 0){
                let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            }
        }
        
        
        return request
    }
}

