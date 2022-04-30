//
//  ListEventsUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class ListEventsUIComposer {
    private init() {}
    
    static func makeListEventsController() -> ListEventsViewController {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let authenticationTokenHeader = KeychainHelper.instance.getAuthenticationTokenHeader()
        
        let eventLoader = RemoteEventLoader(client: loadingClient, baseURL: AppEnvironment.baseURL, authenticationTokenHeader: authenticationTokenHeader)
        
        let viewModel = ListEventsViewModel(eventLoader: eventLoader)
        let refreshController = ListEventsRefreshController(viewModel: viewModel)
        
        let listEventsViewController = ListEventsViewController(categories:
                        [EventCategoryCellController(viewModel: EventCategoryViewModel(status: .UPCOMING)),
                         EventCategoryCellController(viewModel: EventCategoryViewModel(status: .ENDED)),
                         EventCategoryCellController(viewModel: EventCategoryViewModel(status: .CANCELLED))],
                                                                refreshController: refreshController)
        
        let router = ListEventsRouter()
        router.viewController = listEventsViewController
        
        
        
        viewModel.onEventsLoaded = { [weak listEventsViewController] events in
            listEventsViewController?.display(events.map { event in
                let viewModel = EventViewModel(model: event) {
                    router.openBroadcastModule(with: event.id)
                }
                return ListEventCellController(viewModel: viewModel)
            })
        }
        
        viewModel.onError = { message in
            router.openAlertModule(message: message)
        }
        
        return listEventsViewController
    }
}
