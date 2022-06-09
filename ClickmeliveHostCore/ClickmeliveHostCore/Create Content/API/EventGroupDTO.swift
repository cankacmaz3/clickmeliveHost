//
//  EventGroupDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Foundation

extension EventGroupDTO {
    public func toDomain() -> EventGroup {
        return .init(id: groupId ?? -1,
                     name: name ?? "")
    }
}

public struct EventGroupDTO: Decodable {
    private let groupId: Int?
    private let name: String?
}
