//
//  EventLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

public protocol EventLoader {
    typealias Result = Swift.Result<Paginated<EventResponse>, Error>
    
    func load(with status: [Event.EventStatus], page: Int, completion: @escaping (Result) -> Void)
}
