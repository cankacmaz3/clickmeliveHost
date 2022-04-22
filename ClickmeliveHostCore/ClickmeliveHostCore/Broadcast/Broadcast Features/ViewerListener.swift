//
//  ViewerListener.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public protocol ViewerListener {
    typealias Result = Swift.Result<Int, Error>
    
    func connect(eventId: Int, completion: @escaping (Result) -> Void)
    func disconnect()
}
