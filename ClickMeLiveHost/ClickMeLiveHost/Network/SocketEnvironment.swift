//
//  SocketEnvironment.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import Foundation

enum SocketEnvironment {
    case production
    case development
}

extension SocketEnvironment {
    static var currentState: SocketEnvironment {
        return .development
    }
}

extension SocketEnvironment {
    static var baseURL: URL {
        switch SocketEnvironment.currentState {
        case .production:
            return URL(string: Servers.socketProduction)!
        case .development:
            return URL(string: Servers.socketDevelopment)!
        }
    }
}

extension SocketEnvironment {
    static var showLog: Bool {
        switch SocketEnvironment.currentState {
        default:
            return true
        }
    }
}

