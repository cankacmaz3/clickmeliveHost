//
//  EventCategoryMapper.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Foundation

public final class EventCategoryMapper {
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private static var OK_200: Int { return 200 }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [EventCategory] {
        
        guard response.statusCode == OK_200,
            let root = try? JSONDecoder().decode([EventCategoryDTO].self, from: data) else {
                throw Error.invalidData
        }
        
        let categories = root.map { $0.toDomain() }
        return categories
    }
    
}
