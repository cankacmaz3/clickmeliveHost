//
//  ListVideoUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 29.05.2022.
//


import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class ListVideoUIComposer {
    private init() {}
    
    static func makeListVideosViewController(router: HomeRouter) -> ListVideosViewController {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let authenticationTokenHeader = KeychainHelper.instance.getAuthenticationTokenHeader()
        
        let eventLoader = RemoteEventLoader(client: loadingClient, baseURL: AppEnvironment.baseURL, authenticationTokenHeader: authenticationTokenHeader)
        
        let authTokenLoader = AuthTokenLoader(store: AuthTokenStore())
        let eventRemover = RemoteEventRemover(client: loadingClient, baseURL: AppEnvironment.baseURL, authTokenLoader: authTokenLoader)
        let listVideosViewModel = ListVideosViewModel(eventLoader: eventLoader, eventRemover: eventRemover)
        let refreshController = ListVideosRefreshController(viewModel: listVideosViewModel)
        let controller = ListVideosViewController(refreshController: refreshController)
        
        listVideosViewModel.onEventsLoaded = { [weak controller] events in
            controller?.display(events.map { event in
                let viewModel = EventViewModel(model: event)
                let cellController = ListVideosCellController(viewModel: viewModel,
                                                              imageLoader: SDImageLoader(),
                                                              selection: {
                    guard let url = viewModel.videoURL else { return }
                    router.openVideoModule(url: url)
                })
                
                cellController.onDeleteTapped = {
                    router.openAlertModule(message: viewModel.deleteMessage,
                                           buttonTitle: viewModel.approveDelete,
                                           cancelButtonTitle: viewModel.cancelDelete) {
                        controller?.deleteTapped(eventId: event.id)
                    }
                }
                
                cellController.onEditTapped = {
                    router.openVideoContentModule(event: event)
                }
                
                return cellController
            })
        }
        
        return controller
    }
}

