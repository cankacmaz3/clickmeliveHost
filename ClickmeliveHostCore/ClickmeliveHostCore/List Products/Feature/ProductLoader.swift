//
//  ProductLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation

public protocol ProductLoader {
    typealias Result = Swift.Result<Paginated<ProductResponse>, Error>
    
    func load(name: String?, page: Int, completion: @escaping (Result) -> Void)
}

