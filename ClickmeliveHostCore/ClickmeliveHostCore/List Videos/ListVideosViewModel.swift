//
//  ListVideosViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation
import Combine

public final class ListVideosViewModel {
    private var disposables = Set<AnyCancellable>()
    
    public typealias Observer<T> = (T) -> Void
    public typealias Next<T> = (Result<Paginated<T>, Error>) -> Void
    
    private let eventLoader: EventLoader
    private let eventRemover: EventRemover
   
    public init(eventLoader: EventLoader,
                eventRemover: EventRemover) {
        self.eventLoader = eventLoader
        self.eventRemover = eventRemover
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
    
    public var placeholderTitle: String {
        Localized.ListEvents.emptyVideos
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

extension ListVideosViewModel {
    public func deleteEvent(eventId: Int) {
        eventRemover.remove(eventId: eventId).sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished: break
                    
                case let .failure(error):
                    self.onError?(error.localizedDescription)
                }
        }, receiveValue: { [weak self] _ in
            self?.loadVideos(status: [.SHORT_VIDEO, .LONG_VIDEO])
        }).store(in: &disposables)
    }
}
