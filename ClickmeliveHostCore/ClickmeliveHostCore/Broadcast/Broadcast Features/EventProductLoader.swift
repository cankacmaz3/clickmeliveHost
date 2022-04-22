//
//  EventProductLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public protocol EventProductLoader {
    typealias Result = Swift.Result<[Product], Error>
    
    func load(eventId: Int, completion: @escaping (Result) -> Void)
}

