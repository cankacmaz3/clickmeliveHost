//
//  EventRemover.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Combine

public protocol EventRemover {
    func remove(eventId: Int) -> AnyPublisher<Void, Error>
}
