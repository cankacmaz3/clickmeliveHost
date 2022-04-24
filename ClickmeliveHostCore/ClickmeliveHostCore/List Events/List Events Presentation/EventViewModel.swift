//
//  EventViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import Foundation

public final class EventViewModel {
    public typealias Observer<T> = (T) -> Void
    
    public let select: () -> Void
    private let model: Event
   
    public init(model: Event, selection: @escaping () -> Void) {
        self.model = model
        self.select = selection
    }
        
    public var title: String {
        model.title
    }
    
    public var image: String? {
        model.image
    }
    
    public var startingDate: String? {
        model.startingDate?.convertDateToString(returnFormat: .upcomingFormat)
    }
    
    public var status: Event.EventStatus {
        model.status
    }
    
    private var broadcastableTimeInterval: Double { return 60 * 10 } // 10 minutes
    private var soonStatusTimeInterval: Double { return 60 * 10 * 6 } // 60 minutes
   
    public var isStartBroadcastHidden: Bool {
        guard let startingDate = model.startingDate, status != .UPCOMING else {
            return true
        }

        return (Date() - startingDate) < broadcastableTimeInterval
    }
    
    public var isStatusSoon: Bool {
        guard let startingDate = model.startingDate else {
            return true
        }

        return (Date() - startingDate) <= soonStatusTimeInterval
    }
    
    public var localizedStatus: String? {
        switch model.status {
        case .UPCOMING:
            if isStartBroadcastHidden == false {
                return Localized.ListEvents.statusStartBroadcast
            } else if isStatusSoon == true {
                return Localized.ListEvents.statusSoon
            } else {
                return Localized.ListEvents.statusApproved
            }
        case .ENDED:
            return Localized.ListEvents.statusEnded
        case .CANCELLED:
            return Localized.ListEvents.categoryStatusCancelled
        default:
            return nil
        }
    }
}

