//
//  ProductViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public final class ProductViewModel {
    
    private let model: Product
    
    public init(model: Product) {
        self.model = model
    }
    
    public var id: Int {
        model.id
    }
    
    public var name: String {
        model.name
    }
    
    public var image: String? {
        model.image
    }
    
    public var imageURL: URL? {
        guard let image = model.image else { return nil }
        return URL(string: image)
    }
    
    public var price: String {
        model.showPrice()
    }
    
    public var discountedPrice: String? {
        model.showDiscountedPrice()
    }
    
    public var stockQuantity: String? {
        let message = String(format: Localized.Stock.count, model.stockQuantity)
        return message
    }
}

extension ProductViewModel: Hashable {
    public static func == (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
