//
//  EventViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import Foundation

public final class EventViewModel {
    public typealias Observer<T> = (T) -> Void
    
    private let model: Event
   
    public init(model: Event) {
        self.model = model
    }
        
    public var title: String {
        model.title
    }
    
    public var image: String? {
        model.image
    }
    
    public var imageURL: URL? {
        guard let image = model.image else {
            return nil
        }
        return URL(string: image)
    }
    public var videoURL: URL? {
        guard let video = model.video else {
            return nil
        }
        return URL(string: video)
    }
    
    public var startingDate: String? {
        model.startingDate?.convertDateToString(returnFormat: .upcomingFormat)
    }
    
    public var status: Event.EventStatus {
        model.status
    }
    
    private var broadcastableTimeInterval: Double { return 60 * 10 } // 10 minutes
    private var soonStatusTimeInterval: Double { return 60 * 10 * 6 } // 60 minutes
   
    public var isStatusStartBroadcast: Bool {
        guard let startingDate = model.startingDate, status == .UPCOMING || status == .LIVE else {
            return false
        }
        
        return (Date() - startingDate) >= -broadcastableTimeInterval
    }
    
    public var isStatusSoon: Bool {
        guard let startingDate = model.startingDate, status == .UPCOMING else {
            return false
        }
        
        return (Date() - startingDate) >= -soonStatusTimeInterval
    }
    
    public var localizedStatus: String? {
        switch model.status {
        case .UPCOMING, .LIVE:
            if isStatusStartBroadcast == true {
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

