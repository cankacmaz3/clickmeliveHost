//
//  CategoryLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Combine

public protocol EventCategoryLoader {
    func load() -> AnyPublisher<[EventCategory], Error>
}
