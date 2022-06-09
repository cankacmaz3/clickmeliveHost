//
//  EventGroupLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Combine

public protocol EventGroupLoader {
    func load() -> AnyPublisher<[EventGroup], Error>
}
