//
//  EventDetailLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import Foundation

public protocol EventDetailLoader {
    typealias Result = Swift.Result<Event, Error>
    
    func perform(eventId: Int, status: Event.EventStatus, completion: @escaping (Result) -> Void)
}


