//
//  EventListViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 23.04.2022.
//

import Foundation

public final class ListEventsViewModel {
    public typealias Observer<T> = (T) -> Void
    public typealias Next<T> = (Result<Paginated<T>, Error>) -> Void
    
    private let eventLoader: EventLoader
   
    public init(eventLoader: EventLoader) {
        self.eventLoader = eventLoader
    }
    
    // MARK: - State
    public var selectedStatus: Event.EventStatus?
    private var events: [Event] = []
    
    // MARK: - Observers
    public var onEventsLoadingStateChange: Observer<Bool>?
    public var onEventsLoaded: Observer<[Event]>?
    public var onError: (() -> Void)?
    
    private var nextEventResult: ((@escaping Next<EventResponse>) -> ())? = nil
    
    public var localizedPlaceholderTitles: String? {
        switch selectedStatus {
        case .UPCOMING:
            return Localized.ListEvents.placeholderUpcoming
        case .ENDED:
            return Localized.ListEvents.placeholderEnded
        case .CANCELLED:
            return Localized.ListEvents.placeholderCancelled
        default:
            return nil
        }
    }
}

// MARK: - Network related methods
extension ListEventsViewModel {
    public func loadEvents() {
        
        guard let status = selectedStatus else { return }
        
        onEventsLoadingStateChange?(true)
        eventLoader.load(with: status, page: 1) { [weak self] result in
            switch result {
            case let .success(eventResponse):
                self?.events = []
                self?.newEventsHandling(result: eventResponse, error: nil)
            case .failure:
                self?.onError?()
            }
            self?.onEventsLoadingStateChange?(false)
        }
    }
    
    public func onNextEvent() {
        self.nextEventResult?() { [weak self] result  in
            switch result {
            case let .success(nextEvents):
                self?.newEventsHandling(result: nextEvents, error: nil)
            case .failure:
                print("failure")
            }
        }
    }
    
    private func newEventsHandling(result: Paginated<EventResponse>, error: Error?) {
        
        guard let newItems = result.value?.events, let next = result.next else {
            return
        }
        
        self.nextEventResult = result.value?.loadMore == true ? next: nil
        self.events = self.events + newItems
        
        onEventsLoaded?(self.events)
    }
}
