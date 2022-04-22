//
//  AuthCodeValidator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public protocol AuthCodeValidator {
    typealias Result = Swift.Result<ValidateCode, CMLError>
    
    func perform(validateCodeRequest: ValidateCodeRequest, completion: @escaping (Result) -> Void)
}
