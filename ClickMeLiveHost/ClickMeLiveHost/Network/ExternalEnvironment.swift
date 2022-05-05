//
//  ExternalEnvironment.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import Foundation

enum ExternalEnvironment {
    static var baseURL: URL {
        switch AppEnvironment.currentState {
        case .production:
            return URL(string: Servers.externalProduction)!
        case .development:
            return URL(string: Servers.externalDevelopment)!
        }
    }
}
