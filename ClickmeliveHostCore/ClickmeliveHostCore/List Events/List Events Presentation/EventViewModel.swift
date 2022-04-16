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
}

