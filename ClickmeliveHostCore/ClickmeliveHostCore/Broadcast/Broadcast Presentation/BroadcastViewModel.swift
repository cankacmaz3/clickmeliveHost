//
//  BroadcastViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 23.04.2022.
//

import Foundation

public final class BroadcastViewModel {
    public typealias Observer<T> = (T) -> Void
    
    private let eventDetailLoader: EventDetailLoader
    
    public init(eventDetailLoader: EventDetailLoader) {
        self.eventDetailLoader = eventDetailLoader
    }
    
    // MARK: - States
    public var isRunning: Bool = false {
        didSet {
            isRunningValueChanged?(isRunning)
        }
    }
    
    public var isMuted: Bool = false {
        didSet {
            isMutedValueChanged?()
        }
    }
    
    public var timer = ElapsedTimeAndDataManager()
    
    public var isRunningValueChanged: Observer<Bool>?
    public var isMutedValueChanged: (() -> Void)?
    
    public var onStatusUpdatedToLive: Observer<Event>?
    public var onStatusUpdatedToEnded: (() -> Void)?
    
    public var streamStatus: String {
        isRunning ? Localized.Broadcast.stopBroadcast: Localized.Broadcast.startBroadcast
    }
    
    public func updateStatus(eventId: Int, with status: Event.EventStatus) {
        eventDetailLoader.perform(eventId: eventId, status: status) { [weak self] result in
            switch result {
            case let .success(eventDetail):
                eventDetail.status == .LIVE ?
                self?.onStatusUpdatedToLive?(eventDetail) :
                self?.onStatusUpdatedToEnded?()
            case .failure:
                print("error")
            }
        }
    }
}
