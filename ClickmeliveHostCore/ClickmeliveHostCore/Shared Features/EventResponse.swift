//
//  EventResponse.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation

public struct EventResponse {
    public let events: [Event]
   
    public let pageNumber: Int
    public let pageSize: Int
    public let totalRecordCount: Int
    
    public var loadMore: Bool {
        return totalRecordCount > pageSize * pageNumber
    }
    
}
