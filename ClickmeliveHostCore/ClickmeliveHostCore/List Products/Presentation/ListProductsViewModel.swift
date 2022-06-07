//
//  ListProductsViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation

public final class ListProductsViewModel {
    public typealias Observer<T> = (T) -> Void
    public typealias Next<T> = (Result<Paginated<T>, Error>) -> Void
    
    private let productLoader: ProductLoader
   
    public init(productLoader: ProductLoader) {
        self.productLoader = productLoader
    }
    
    // MARK: - State
    private var products: [Product] = []
    
    // MARK: - Observers
    public var onProductsLoadingStateChange: Observer<Bool>?
    public var onProductsLoaded: Observer<[Product]>?
    public var onError: ((String) -> Void)?
    
    private var nextProductResult: ((@escaping Next<ProductResponse>) -> ())? = nil
    
    public func updateNavigationTitle(selectedProductCount: Int) -> String {
        let message = String(format: Localized.ListProducts.navigationTitle, selectedProductCount)
        return message
    }
    
    public var searchPlaceholder: String {
        Localized.ListProducts.searchPlaceholder
    }
    
    public var save: String {
        Localized.ListProducts.save
    }
    
    public var exceededMaximumProductAlert: String {
        Localized.ListProducts.exceededMaximumProductAlert
    }
    
    private var errorMessage: String {
        Localized.Error.defaultMessage
    }
}

// MARK: - Network related methods
extension ListProductsViewModel {
    public func loadProducts(with name: String? = nil) {
        
        onProductsLoadingStateChange?(true)
        productLoader.load(name: name, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(productResponse):
                self.products = []
                self.newProductsHandling(result: productResponse, error: nil)
            case .failure:
                self.onError?(self.errorMessage)
            }
            self.onProductsLoadingStateChange?(false)
        }
    }
    
    public func onNextProduct() {
        self.nextProductResult?() { [weak self] result  in
            switch result {
            case let .success(nextProducts):
                self?.newProductsHandling(result: nextProducts, error: nil)
            case .failure:
                print("failure")
            }
        }
    }
    
    private func newProductsHandling(result: Paginated<ProductResponse>, error: Error?) {
        
        guard let newItems = result.value?.products, let next = result.next else {
            return
        }
        
        self.nextProductResult = result.value?.loadMore == true ? next: nil
        self.products = self.products + newItems
        
        onProductsLoaded?(self.products)
    }
}

