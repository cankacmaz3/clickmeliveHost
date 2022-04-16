//
//  AppEnvironment.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

enum AppEnvironment {
    case production
    case development
}

extension AppEnvironment {
    static var currentState: AppEnvironment {
        return .development
    }
}

extension AppEnvironment {
    static var baseURL: URL {
        switch AppEnvironment.currentState {
        case .production:
            return URL(string: Servers.production)!
        case .development:
            return URL(string: Servers.development)!
        }
    }
}

extension AppEnvironment {
    static var showLog: Bool {
        switch AppEnvironment.currentState {
        case .production:
            return true
        case .development:
            return true
        }
    }
}

