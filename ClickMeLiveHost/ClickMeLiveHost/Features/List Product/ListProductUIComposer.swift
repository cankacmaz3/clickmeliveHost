//
//  ListProductUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class ListProductUIComposer {
    private init() {}
    
    static func makeListProductsViewController(selectedProducts: [ProductViewModel], openTransition: Transition) -> ListProductsViewController {
        
        let router = ListProductRouter()
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let authenticationTokenHeader = ["Token": "eyJ1c2VySWQiOjEwMCwidHlwZSI6MiwiZGV2aWNlSWQiOjIwMSwiZXhwaXJlIjoiMjA5OS0xMi0zMVQwMDowMDowMC4wMDBaIiwidGltZSI6IjIwMjEtMTAtMTdUMTM6NTk6MTEuNzQ3WiJ9.ODlkOWUwMDZmYzQ2ZjlkYTQxZDcyOWU4Mzg4YzJiMDZmZjkwZjU3YWQwZDk1YjliZGQyZTc2MWE5NzBjZWI4ZA=="]
        
        let productLoader = RemoteProductLoader(client: loadingClient, baseURL: AppEnvironment.baseURL, authenticationTokenHeader: authenticationTokenHeader)
        let viewModel = ListProductsViewModel(productLoader: productLoader)
        let controller = ListProductsViewController(viewModel: viewModel)
        router.viewController = controller
        router.openTransition = openTransition
        
        viewModel.onProductsLoaded = { products in
            let imageLoader = SDImageLoader()
            controller.display(products.map { product in
                let productViewModel = ProductViewModel(model: product)
                return ListProductCellController(viewModel: productViewModel,
                                                 imageLoader: imageLoader)
            }, selectedProducts: selectedProducts)
        }
       
        controller.onSaveTapped = {
            router.close()
        }
        
        controller.onExceededMaxProductAmount = { message in
            router.openAlertModule(message: message)
        }
        
        return controller
    }
}
