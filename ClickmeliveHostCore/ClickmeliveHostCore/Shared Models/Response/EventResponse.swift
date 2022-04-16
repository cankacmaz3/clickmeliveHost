//
//  EventResponse.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

struct EventResponse: Decodable {
    let events: [EventDTO]?
}
