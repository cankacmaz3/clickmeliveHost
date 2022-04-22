//
//  Product.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public struct Product {
    public let id: Int
    public let name: String
    public let image: String?
    public let discountedPrice: Double?
    public let price: Double
    public let stockQuantity: Int
    public let variants: [Variant]
    public let isSpecialOffer: Bool
    public let sellerId: Int
    public let sellerName: String
    public let sellerImage: String?
    public let description: String
    public let variantId: Int?
    public let categoryName: String
    
    public var selectedVariantId: Int? = nil
    
    private var maxNumberForStockVisibility: Int {
        return 3
    }
    
    public var selectedVariantName: String? {
        variants.first(where: { $0.id == selectedVariantId})?.name
    }
    
    public var stockQuantityForSelectedVariant: Int {
        guard let selectedVariantId = selectedVariantId else { return stockQuantity }
        for variant in variants {
            if variant.id == selectedVariantId { return variant.stockQuantity }
            
            for subVariant in variant.sub {
                if subVariant.id == selectedVariantId { return subVariant.stockQuantity }
            }
        }
        return stockQuantity
    }
    
    public var isStockBadgeVisible: Bool {
        stockQuantityForSelectedVariant <= maxNumberForStockVisibility
    }
    
    public var isStockEnabled: Bool {
        stockQuantityForSelectedVariant > 0
    }
    
    public var colorVariantBadgeCount: Int {
        variants.filter { return $0.isStockEnabled && $0.isColorVariant }.count
    }
    
    public var isColorVariantBadgeVisible: Bool {
        colorVariantBadgeCount > 1
    }
    
    public func showPrice() -> String {
        if let discountedPrice = discountedPrice {
            return discountedPrice.priceFormat()
        } else {
            return price.priceFormat()
        }
    }
    
    public func showDiscountedPrice() -> String? {
        return discountedPrice != nil ? price.priceFormat() : nil
    }
    
    public struct Variant {
        public let id: Int
        public let variant: VariantType
        public let name: String
        public let image: String?
        public let stockQuantity: Int
        public let sub: [Variant]
        
        public var isStockEnabled: Bool {
            stockQuantity > 0
        }
        
        public var isColorVariant: Bool {
            variant == .COLOR
        }
        
        public enum VariantType: String {
            case COLOR
            case BODY_SIZE
            case NONE
            
            static func get(name: String?) -> VariantType {
                switch name {
                case "COLOR":
                    return .COLOR
                case "BODY_SIZE":
                    return .BODY_SIZE
                default:
                    return .NONE
                }
            }
        }
    }
}
