//
//  AuthTokenLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 25.05.2022.
//

import Foundation

public final class AuthTokenLoader {
    private let store: TokenStore
    
    public init(store: TokenStore) {
        self.store = store
    }
    
    public func load() -> String? {
        return store.retrieveToken()
    }
}
