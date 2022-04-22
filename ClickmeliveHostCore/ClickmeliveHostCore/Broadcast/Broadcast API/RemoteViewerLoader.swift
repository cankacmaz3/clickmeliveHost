//
//  RemoteViewerLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public final class RemoteViewerListener: ViewerListener {
    
    private let socketConnection: WebSocketConnector
    
    public typealias Result = ViewerListener.Result
    
    public init(socketConnection: WebSocketConnector) {
        self.socketConnection = socketConnection
    }
    
    public func connect(eventId: Int, completion: @escaping (Result) -> Void) {
        socketConnection.establishConnection()
        
        socketConnection.didReceiveMessage = { message in
            self.dispatch {
                let response = message.parse(to: VirtualViewerDTO.self)
                completion(.success(response?.stats?.viewers?.virtualViewer ?? 0))
            }
        }
    }
    
    public func disconnect() {
        socketConnection.disconnect()
    }
    
    private func dispatch(completion: @escaping () -> Void) {
        return DispatchQueue.main.async(execute: completion)
    }
}

