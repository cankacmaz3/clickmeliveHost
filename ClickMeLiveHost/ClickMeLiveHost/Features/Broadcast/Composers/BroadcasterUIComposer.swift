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
    
    static func makeBroadcastViewController(eventId: Int, openTransition: Transition) -> BroadcastViewController {
        let router = BroadcasterRouter()
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 60.0
        
        let client = URLSessionHTTPClient(session: URLSession(configuration: sessionConfig))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let eventProductLoader = RemoteEventProductLoader(client: client, baseURL: AppEnvironment.baseURL, authenticationTokenHeader: KeychainHelper.instance.getAuthenticationTokenHeader())
        let eventProductViewModel = EventProductViewModel(eventProductLoader: eventProductLoader)
        let broadcastEventProductsController = BroadcastEventProductsController(viewModel: eventProductViewModel)
        
        let socketConnector = WebSocketConnector(withSocketURL: URL(string: "\(SocketEnvironment.baseURL)\(eventId)")!)
        let viewerListener = RemoteViewerListener(socketConnection: socketConnector)
        
        let eventDetailLoader = RemoteEventDetailLoader(client: loadingClient, baseURL: ExternalEnvironment.baseURL)
        
        let broadcasterViewModel = BroadcastViewModel(eventDetailLoader: eventDetailLoader)
        let viewerViewModel = ViewerViewModel(viewerListener: viewerListener)
        let broadcastViewController = BroadcastViewController(eventId: eventId,
                                                              broadcastViewModel: broadcasterViewModel,
                                                              viewerViewModel: viewerViewModel,
                                                              broadcastEventProductsController: broadcastEventProductsController)
        
        router.viewController = broadcastViewController
        router.openTransition = openTransition
        
        eventProductViewModel.onEventProductsLoaded = { products in
            broadcastEventProductsController.display(products.map { product in
                let viewModel = ProductViewModel(model: product)
                return ProductCellController(viewModel: viewModel)
            })
        }
        
        broadcastViewController.onClose = {
            router.close()
        }
        
        return broadcastViewController
    }
}
