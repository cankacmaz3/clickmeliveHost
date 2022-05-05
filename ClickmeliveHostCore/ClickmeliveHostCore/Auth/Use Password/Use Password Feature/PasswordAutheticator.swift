//
//  PasswordAutheticator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.05.2022.
//

import Foundation

public protocol PasswordAutheticator {
    typealias Result = Swift.Result<Login, CMLError>
    
    func perform(passwordAuthenticationRequest: PasswordAuthenticationRequest, completion: @escaping (Result) -> Void)
}
