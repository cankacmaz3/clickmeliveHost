//
//  EventCreator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Combine

public protocol EventCreator {
    func createVideo(isActive: Bool, status: Event.EventStatus, title: String, contentId: Int, image: String, video: String, products: [Int], tags: [String], startingDate: String?) -> AnyPublisher<Event, Error>
}
