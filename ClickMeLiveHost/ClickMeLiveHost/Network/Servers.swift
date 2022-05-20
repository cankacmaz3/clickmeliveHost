//
//  Servers.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

struct Servers {
    static let production = "https://dev-azure-broadcaster-api.clickmelive.com"
    static let development = "https://test-azure-broadcaster-api.clickmelive.com"
    
    static let externalProduction = "https://dev-azure-external-api.clickmelive.com"
    static let externalDevelopment = "https://test-azure-external-api.clickmelive.com"
    
    static let socketProduction = "wss://eventstats-prod-api.clickmelive.com/?eventId="
    static let socketDevelopment = "wss://eventstats-test-api.clickmelive.com/?eventId="
}
