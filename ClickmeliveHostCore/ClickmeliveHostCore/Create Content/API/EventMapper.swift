//
//  EventMapper.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Foundation

public final class EventMapper {
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private static var CREATED_201: Int { return 201 }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Event {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMddTHHmmssSSSZ)
        
        guard response.statusCode == CREATED_201,
            let root = try? decoder.decode(EventDTO.self, from: data) else {
                throw Error.invalidData
        }
        
        return root.toDomain()
    }
    
}
