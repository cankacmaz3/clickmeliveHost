//
//  EventCategoryViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 19.04.2022.
//

import Foundation

public final class EventCategoryCellViewModel {
    
    public let status: Event.EventStatus
    
    public init(status: Event.EventStatus) {
        self.status = status
    }
    
    public var selectedStatus: Event.EventStatus?
    
    public var localizedIndex: String {
        switch status {
        case .UPCOMING:
            return "Gelecek Yayınlar"
        case .ENDED:
            return "Geçmiş Yayınlar"
        case .CANCELLED:
            return "Reddedilen Yayınlar"
        default:
            return "Tümü"
        }
    }
}
