//
//  EventProductViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public final class EventProductViewModel {
    public typealias Observer<T> = (T) -> Void
    
    private let eventProductLoader: EventProductLoader
    
    public init(eventProductLoader: EventProductLoader) {
        self.eventProductLoader = eventProductLoader
    }
    
    public var onEventProductsLoaded: Observer<[Product]>?
    
    public func loadEventProducts(eventId: Int) {
        print(eventId)
        eventProductLoader.load(eventId: eventId) { [weak self] result in
            switch result {
            case let .success(products):
                self?.onEventProductsLoaded?(products)
            case .failure:
                print("error")
            }
        }
    }
}
