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
    
    public var name: String {
        model.name
    }
    
    public var image: String? {
        model.image
    }
    
    public var price: String {
        model.showPrice()
    }
    
    public var discountedPrice: String? {
        model.showDiscountedPrice()
    }
}
