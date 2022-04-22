//
//  AlertViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public final class AlertViewModel {
    
    private let alert: Alert
    
    public init(alert: Alert) {
        self.alert = alert
    }
    
    public var message: String {
        return alert.message
    }
    
    public var actionButtonTitle: String {
        return alert.buttonTitle ?? Localized.Alert.defaultActionButtonTitle
    }
}

