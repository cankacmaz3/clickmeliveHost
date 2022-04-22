//
//  BroadcasterUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class BroadcasterUIComposer {
    private init() {}
    
    static func makeBroadcastViewController() -> BroadcastViewController {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let authenticationTokenHeader = ["Token": "eyJ1c2VySWQiOjk2LCJ0eXBlIjoyLCJkZXZpY2VJZCI6MTk1LCJleHBpcmUiOiIyMDk5LTEyLTMxVDAwOjAwOjAwLjAwMFoiLCJ0aW1lIjoiMjAyMi0wNC0yMFQxOTo0NDoyMy41NTJaIn0=.MTk1MzcxZjJmNjE3Yjg1OTUxMWNiMGY0MGMyZWRkOWMxZjlkYTM5ZTEzZmY4ODQwODgyMDZkMDA1NTk0NzlkMQ=="]
        
        let eventProductLoader = RemoteEventProductLoader(client: loadingClient, baseURL: AppEnvironment.baseURL, authenticationTokenHeader: authenticationTokenHeader)
        let eventProductViewModel = EventProductViewModel(eventProductLoader: eventProductLoader)
        let broadcastEventProductsController = BroadcastEventProductsController(viewModel: eventProductViewModel)
        let broadcastViewController = BroadcastViewController(broadcastEventProductsController: broadcastEventProductsController)
        
        eventProductViewModel.onEventProductsLoaded = { products in
            broadcastEventProductsController.display(products.map { product in
                let viewModel = ProductViewModel(model: product)
                return ProductCellController(viewModel: viewModel)
            })
        }
        
        return broadcastViewController
    }
}
