//
//  URLSessionHTTPClient.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
   
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func execute(with request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        log(request: request)
        
        let task = session.dataTask(with: request) { data, response, error in
            self.dispatch {
                completion(Result {
                    if let error = error {
                        throw error
                    } else if let data = data, let response = response as? HTTPURLResponse {
                        return (data, response)
                    } else {
                        throw UnexpectedValuesRepresentation()
                    }
                })
            }
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
    
    private func dispatch(completion: @escaping () -> Void) {
        return DispatchQueue.main.async(execute: completion)
    }
}

extension URLSessionHTTPClient {
    private func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
}

