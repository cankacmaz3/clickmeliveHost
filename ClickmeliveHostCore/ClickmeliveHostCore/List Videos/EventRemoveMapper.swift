//
//  EventRemoveMapper.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation

public final class EventRemoveMapper {
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Void {
        guard isOK(response) else {
            throw Error.invalidData
        }
    }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        (200...299).contains(response.statusCode)
    }
}
