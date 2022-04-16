//
//  EventLoader.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

public protocol EventLoader {
    typealias Result = Swift.Result<[Event], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
