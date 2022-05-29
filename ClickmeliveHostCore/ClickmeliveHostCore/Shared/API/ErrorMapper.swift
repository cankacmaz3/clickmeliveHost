//
//  ErrorMapper.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation

public final class ErrorMapper {
    public static func map(_ error: Error) -> CMLError {
        switch error {
        case let cmlError as CMLErrorDTO:
            return cmlError.toDomain()
        default:
            return .init(message: Localized.Error.defaultMessage)
        }
    }
}
