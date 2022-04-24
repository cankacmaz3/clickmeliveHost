//
//  ExternalEnvironment.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import Foundation

enum ExternalEnvironment {
    case production
    case development
}

extension ExternalEnvironment {
    static var currentState: ExternalEnvironment {
        return .development
    }
}

extension ExternalEnvironment {
    static var baseURL: URL {
        switch ExternalEnvironment.currentState {
        case .production:
            return URL(string: Servers.externalProduction)!
        case .development:
            return URL(string: Servers.externalDevelopment)!
        }
    }
}

extension ExternalEnvironment {
    static var showLog: Bool {
        switch ExternalEnvironment.currentState {
        default:
            return true
        }
    }
}
