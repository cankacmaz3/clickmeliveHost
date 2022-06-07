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
        return .init(products: products,
                     pageNumber: _metadata?.pageNumber ?? 0,
                     pageSize: _metadata?.pageSize ?? 0,
                     totalRecordCount: _metadata?.totalRecordCount ?? 0)
    }
}

struct ProductResponseDTO: Decodable {
    let _metadata: Metadata?
    let products: [ProductDTO]?
}
