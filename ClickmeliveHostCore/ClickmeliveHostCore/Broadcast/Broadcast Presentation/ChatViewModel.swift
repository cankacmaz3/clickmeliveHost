//
//  ChatViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 3.05.2022.
//

import Foundation

public final class ChatViewModel {
    
    private let model: ChatMessage
    
    public init(model: ChatMessage) {
        self.model = model
    }
    
    public var username: String? {
        guard let username = model.username else {
            return nil
        }

        return "@\(username)"
    }
    
    public var message: String? {
        model.message
    }
}
