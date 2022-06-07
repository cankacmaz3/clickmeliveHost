//
//  ProductResponse.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public struct ProductResponse {
    public let products: [Product]
    
    public let pageNumber: Int
    public let pageSize: Int
    public let totalRecordCount: Int
    
    public var loadMore: Bool {
        return totalRecordCount > pageSize * pageNumber
    }
}
