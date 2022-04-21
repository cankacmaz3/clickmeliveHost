//
//  AuthCodeCreator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public protocol AuthCodeCreator {
    typealias Result = Swift.Result<CreateCode, Error>
    
    func perform(phone: String, completion: @escaping (Result) -> Void)
}
