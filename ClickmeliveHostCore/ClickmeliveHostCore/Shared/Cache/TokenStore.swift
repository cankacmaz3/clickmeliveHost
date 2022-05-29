//
//  TokenStore.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 25.05.2022.
//

import Foundation

public protocol TokenStore {
    func deleteToken()
    func saveToken(_ token: String) throws
    func retrieveToken() -> String?
}

