//
//  ListEventsViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

public final class ListEventsViewModel {
    public typealias Observer<T> = (T) -> Void
    
    private let eventLoader: EventLoader
   
    public init(eventLoader: EventLoader) {
        self.eventLoader = eventLoader
    }
    
    public var onEventsLoadingStateChange: Observer<Bool>?
    public var onEventsLoaded: Observer<[Event]>?
    public var onError: (() -> Void)?
    
    public func loadEvents() {
        onEventsLoadingStateChange?(true)
        eventLoader.load { [weak self] result in
            switch result {
            case let .success(events):
                self?.onEventsLoaded?(events)
            case .failure:
                self?.onError?()
            }
            self?.onEventsLoadingStateChange?(false)
        }
    }
}
