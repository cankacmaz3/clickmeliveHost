//
//  CMLErrorDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

extension CMLErrorDTO {
    func toDomain() -> CMLError {
        let message = code.showLocalizedErrorMessage()
        return .init(message: message)
    }
}

struct CMLErrorDTO: Error, Decodable {
    let code: String
}
