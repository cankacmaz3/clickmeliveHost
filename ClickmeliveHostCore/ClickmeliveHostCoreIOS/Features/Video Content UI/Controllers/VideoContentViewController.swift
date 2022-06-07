//
//  VideoContentViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit
import Combine
import ClickmeliveHostCore

public final class VideoContentViewController: UIViewController, Layouting {
    
    public typealias ViewType = VideoContentView
    
    public var onAddProductSelected = PassthroughSubject<[ProductViewModel], Never>()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        registerActions()
    }
    
    deinit {
        print("deinit VideoContentViewController")
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    private func registerActions() {
        layoutableView.listProductsView.onAddProductTapped = { [weak self] productViewModels in
            self?.onAddProductSelected.send(productViewModels)
        }
    }
}

extension VideoContentViewController: ListProductsDelegate {
    public func selectedProducts(products: [ProductViewModel]) {
        layoutableView.listProductsView.display(products: products)
    }
}
