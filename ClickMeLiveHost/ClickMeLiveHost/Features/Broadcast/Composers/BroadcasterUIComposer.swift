//
//  BroadcasterUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS
import FirebaseDatabase

final class BroadcasterUIComposer {
    private init() {}
    
    static func makeBroadcastViewController(event: Event, openTransition: Transition) -> BroadcastViewController {
        
        let router = BroadcasterRouter()
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 20.0
        sessionConfig.timeoutIntervalForResource = 60.0
        
        let client = URLSessionHTTPClient(session: URLSession(configuration: sessionConfig))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let eventProductLoader = RemoteEventProductLoader(client: client, baseURL: AppEnvironment.baseURL, authenticationTokenHeader: KeychainHelper.instance.getAuthenticationTokenHeader())
        let eventProductViewModel = EventProductViewModel(eventProductLoader: eventProductLoader)
        let broadcastEventProductsController = BroadcastEventProductsController(viewModel: eventProductViewModel)
        
        let socketConnector = WebSocketConnector(withSocketURL: URL(string: "\(SocketEnvironment.baseURL)\(event.id)")!)
        let viewerListener = RemoteViewerListener(socketConnection: socketConnector)
        
        let eventDetailLoader = RemoteEventDetailLoader(client: loadingClient, baseURL: ExternalEnvironment.baseURL)
        
        let broadcasterViewModel = BroadcastViewModel(eventDetailLoader: eventDetailLoader)
        let viewerViewModel = ViewerViewModel(viewerListener: viewerListener)
        
        let broadcastChatController = BroadcastChatController()
        let broadcastViewController = BroadcastViewController(event: event,
                                                              broadcastViewModel: broadcasterViewModel,
                                                              viewerViewModel: viewerViewModel,
                                                              broadcastEventProductsController: broadcastEventProductsController,
                                                              broadcastChatController: broadcastChatController)
        
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
        
        broadcasterViewModel.onStartBroadcastError = { message in
            router.openAlertModule(message: message)
        }
        
        FirebaseChatLoader.instance.observeMessages(operationCode: event.operationCode, completion: {  chatMessage in
            broadcastChatController.updateCellControllers(ChatCellController(viewModel: ChatViewModel(model: chatMessage)))
        })
        
        broadcastViewController.onViewWillDisappear {
            FirebaseChatLoader.instance.removeObservers()
        }
        
        return broadcastViewController
    }
}

final class FirebaseChatLoader {
    
    static let instance = FirebaseChatLoader()
    private init() {}
    
    private var fbRefEvents: String { return "events" }
    private var fbQueryTimestamp: String { return "timestamp" }
    
    private var ref: DatabaseReference?
    
    func observeMessages(operationCode: String?, completion: @escaping (ChatMessage) -> Void) {
        guard let operationCode = operationCode else {
            return
        }

        self.ref = Database.database().reference().child(fbRefEvents).child(operationCode)
        
        removeObservers()
        let query = ref?.queryOrdered(byChild: fbQueryTimestamp).queryStarting(atValue: Int(Date().timeIntervalSince1970))
        query?.observe(.childAdded, with: {
            (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let chatMessage = ChatMessage(dictionary: dictionary)
            completion(chatMessage)
        })
    }
    
    func removeObservers() {
        ref?.removeAllObservers()
    }
}
