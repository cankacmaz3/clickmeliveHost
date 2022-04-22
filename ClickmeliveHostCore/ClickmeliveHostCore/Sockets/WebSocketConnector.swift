//
//  WebSocketConnector.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public protocol WebSocketProtocol {
    func send(message : String)
    func send(data : Data)
    func establishConnection()
    func disconnect()
}

public class WebSocketConnector : NSObject {
    
    var didOpenConnection : (()->())?
    var didCloseConnection : (()->())?
    var didReceiveMessage : ((_ message : String)->())?
    var didReceiveData : ((_ message : Data)->())?
    var didReceiveError : ((_ error : Error)->())?

    
    var urlSession : URLSession!
    var operationQueue : OperationQueue = OperationQueue()
    var socket : URLSessionWebSocketTask!
    
    
    public init(withSocketURL url : URL){
        super.init()
        urlSession  = URLSession(configuration: .default, delegate: self, delegateQueue: operationQueue)
        socket = urlSession.webSocketTask(with: url)
        
    }
    
    private func addListener(){
        
        socket.receive {[weak self] (result) in
            switch result {
            case .success(let response):
                switch response {
                    
                case .data(let data):
                    self?.didReceiveData?(data)

                case .string(let message):
                    self?.didReceiveMessage?(message)
                @unknown default:
                    break
                }
            case .failure(let error):
                self?.didReceiveError?(error)
            }
            self?.addListener()

        }
    }
}

extension WebSocketConnector : WebSocketProtocol {
    
    public func establishConnection(){
        socket.resume()
        addListener()
    }
    
    public func disconnect(){
        socket.cancel(with: .goingAway, reason: nil)
    }
    
    
    public func send(message: String) {
        socket.send(URLSessionWebSocketTask.Message.string(message)) {[weak self] (error) in
            if let error = error {
                self?.didReceiveError?(error)
            }
        }
    }
    
    public func send(data: Data) {
        socket.send(URLSessionWebSocketTask.Message.data(data)) {[weak self] (error) in
            if let error = error {
                self?.didReceiveError?(error)
            }
        }
    }
    
}

extension WebSocketConnector : URLSessionWebSocketDelegate {
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        didOpenConnection?()
    }
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        didCloseConnection?()
    }
}


