//
//  ListProductRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

protocol ListProductRoute {
    var listProductTransition: Transition { get }
    func openListProductModule(selectedProducts: [ProductViewModel], delegate: ListProductsDelegate)
}

extension ListProductRoute where Self: RouterProtocol {
    func openListProductModule(selectedProducts: [ProductViewModel], delegate: ListProductsDelegate) {
        let module = ListProductUIComposer.makeListProductsViewController(selectedProducts: selectedProducts, openTransition: listProductTransition)
        module.delegate = delegate
        open(module, transition: listProductTransition)
    }
}
