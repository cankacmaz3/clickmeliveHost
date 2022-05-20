//
//  AdminEnvironment.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 20.05.2022.
//

import Foundation

enum AdminEnvironment {
    static var baseURL: URL {
        switch AppEnvironment.currentState {
        case .production:
            return URL(string: Servers.adminProduction)!
        case .development:
            return URL(string: Servers.adminProduction)!
        }
    }
}
