//
//  SocketEnvironment.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import Foundation

enum SocketEnvironment {
    static var baseURL: URL {
        switch AppEnvironment.currentState {
        case .production:
            return URL(string: Servers.socketProduction)!
        case .development:
            return URL(string: Servers.socketDevelopment)!
        }
    }
}
