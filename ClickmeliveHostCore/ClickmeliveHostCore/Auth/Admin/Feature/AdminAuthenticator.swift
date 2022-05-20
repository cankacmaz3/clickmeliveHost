//
//  AdminAuthenticator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 20.05.2022.
//

import Foundation

public protocol AdminAuthenticator {
    typealias Result = Swift.Result<Login, CMLError>
    
    func perform(adminAuthenticationRequest: AdminAuthenticationRequest, completion: @escaping (Result) -> Void)
}
