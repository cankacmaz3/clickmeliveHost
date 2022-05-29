//
//  Alert.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public struct Alert {
    public let message: String
    public let buttonTitle: String?
    public let cancelButtonTitle: String?
    
    public init(message: String, buttonTitle: String?, cancelButtonTitle: String?) {
        self.message = message
        self.buttonTitle = buttonTitle
        self.cancelButtonTitle = cancelButtonTitle
    }
}
