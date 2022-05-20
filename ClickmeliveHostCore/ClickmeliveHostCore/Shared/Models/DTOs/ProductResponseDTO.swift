//
//  ProductResponseDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

extension ProductResponseDTO {
    func toDomain() -> ProductResponse {
        let products = products?.map { return $0.toDomain() } ?? []
        return .init(products: products)
    }
}

struct ProductResponseDTO: Decodable {
    let products: [ProductDTO]?
}
