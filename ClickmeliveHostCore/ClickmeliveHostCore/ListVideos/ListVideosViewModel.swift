//
//  ListVideosViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation

public final class ListVideosViewModel {
    public typealias Observer<T> = (T) -> Void
    public typealias Next<T> = (Result<Paginated<T>, Error>) -> Void
    
    private let eventLoader: EventLoader
   
    public init(eventLoader: EventLoader) {
        self.eventLoader = eventLoader
    }
    
    private var events: [Event] = []
    
    // MARK: - Observers
    public var onEventsLoadingStateChange: Observer<Bool>?
    public var onEventsLoaded: Observer<[Event]>?
    public var onError: ((String) -> Void)?
    
    private var nextEventResult: ((@escaping Next<EventResponse>) -> ())? = nil
    
    private var errorMessage: String {
        Localized.Error.defaultMessage
    }
}

// MARK: - Network related methods
extension ListVideosViewModel {
    public func loadVideos(status: [Event.EventStatus]) {
        
        onEventsLoadingStateChange?(true)
        eventLoader.load(with: status, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(eventResponse):
                self.events = []
                self.newEventsHandling(result: eventResponse, error: nil)
            case .failure:
                self.onError?(self.errorMessage)
            }
            self.onEventsLoadingStateChange?(false)
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
