//
//  EnterPhoneViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation

public final class EnterPhoneViewModel {
    
    public init() {}
    
    public var title: String {
        Localized.EnterPhone.title
    }
    
    public var detail: String {
        Localized.EnterPhone.detail
    }
    
    public var phonePlaceholder: String {
        Localized.EnterPhone.phonePlaceholder
    }
    
    public var sendCode: String {
        Localized.EnterPhone.sendCode
    }
}
