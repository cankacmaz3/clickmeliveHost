//
//  EventResponse.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

extension EventResponseDTO {
    func toDomain() -> EventResponse {
        let events = events?.map { return $0.toDomain() } ?? []
        return .init(events: events,
                     pageNumber: _metadata?.pageNumber ?? 0,
                     pageSize: _metadata?.pageSize ?? 0,
                     totalRecordCount: _metadata?.totalRecordCount ?? 0)
    }
}

struct EventResponseDTO: Decodable {
    let _metadata: Metadata?
    let events: [EventDTO]?
}
