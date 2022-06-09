//
//  EventCategoryDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Foundation

extension EventCategoryDTO {
    public func toDomain() -> EventCategory {
        return .init(id: categoryId ?? -1,
                     name: name ?? "")
    }
}

public struct EventCategoryDTO: Decodable {
    private let categoryId: Int?
    private let name: String?
}
