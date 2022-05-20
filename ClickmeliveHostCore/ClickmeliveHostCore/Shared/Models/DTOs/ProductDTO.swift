//
//  ProductDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

extension ProductDTO {
    public func toDomain() -> Product {
        let categoryName = categories?.first(where: { $0.categoryId == self.categoryId})?.name ?? ""
        let variants = variants?.map { $0.toDomain()} ?? []
        return .init(id: productId,
                     name: name,
                     image: image,
                     discountedPrice: discountedPrice,
                     price: price,
                     stockQuantity: stockQuantity ?? 0,
                     variants: variants,
                     isSpecialOffer: isSpecialOffer ?? false,
                     sellerId: seller?.userId ?? -1,
                     sellerName: seller?.username ?? "",
                     sellerImage: seller?.image,
                     description: description ?? "",
                     variantId: variantId,
                     categoryName: categoryName)
    }
}

public struct ProductDTO: Decodable {
    private let productId: Int
    private let name: String
    private let image: String?
    private let discountedPrice: Double?
    private let price: Double
    private let stockQuantity: Int?
    private let variants: [VariantDTO]?
    private let isSpecialOffer: Bool?
    private let seller: SellerDTO?
    private let description: String?
    private let variantId: Int?
    private let categories: [CategoryDTO]?
    private let categoryId: Int?
    
    private struct VariantDTO: Decodable {
        private let variantId: Int?
        private let variant: String?
        private let variantName: String?
        private let ext: Ext?
        private let stockQuantity: Int?
        private let sub: [VariantDTO]?
        
        func toDomain() -> Product.Variant {
            return .init(id: variantId ?? -1,
                         variant: Product.Variant.VariantType.get(name: variant),
                         name: variantName ?? "",
                         image: ext?.image,
                         stockQuantity: stockQuantity ?? 0,
                         sub: sub?.map { $0.toDomain()} ?? [])
        }
    }
    
    private struct Ext: Decodable {
        let image: String?
    }
    
    private struct SellerDTO: Decodable {
        let userId: Int?
        let username: String?
        let image: String?
    }
    
    private struct CategoryDTO: Decodable {
        let categoryId: Int?
        let name: String?
    }
}
