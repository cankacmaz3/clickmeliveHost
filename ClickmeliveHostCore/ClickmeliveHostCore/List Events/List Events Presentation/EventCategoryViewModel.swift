//
//  ListEventsViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

public final class EventCategoryViewModel {
    
    public let status: Event.EventStatus
    
    public init(status: Event.EventStatus) {
        switch status {
        
        case .CANCELLED, .UPCOMING, .ENDED:
            self.status = status
        default:
            fatalError("Invalid Status")
        }
    }
    
    public var localizedIndex: String {
        switch status {
        case .UPCOMING:
            return Localized.ListEvents.categoryStatusUpcoming
        case .ENDED:
            return Localized.ListEvents.categoryStatusEnded
        case .CANCELLED:
            return Localized.ListEvents.categoryStatusCancelled
        default:
            return ""
        }
    }
}
