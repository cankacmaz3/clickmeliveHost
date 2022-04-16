//
//  URLRequestBuilder.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
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
    var baseURL: URL { get }
    var requestURL: URL? { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
    var urlRequest: URLRequest { get }
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
    
    var baseURL: URL {
        return AppEnvironment.baseURL
    }
    
    var requestURL: URL? {
        var urlComponents = URLComponents(string: baseURL.absoluteString)
        urlComponents?.path = path
        if let queryItems = queryItems {
            if(queryItems.count > 0){
                urlComponents?.queryItems = queryItems
            }
        }
        return urlComponents?.url
    }
    
    var urlRequest: URLRequest {
        guard let requestURL = self.requestURL else {
            fatalError("URL could not be built")
        }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = method.rawValue
        request.setValue(version, forHTTPHeaderField: "Client-Version")
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


