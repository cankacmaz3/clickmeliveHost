//
//  ChatMessage.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 3.05.2022.
//

import Foundation

public class ChatMessage: NSObject {
    var username: String?
    var message: String?
    
    public init(dictionary: [String: AnyObject]) {
        super.init()
        self.username = dictionary["username"] as? String
        self.message = dictionary["message"] as? String
    }
}
