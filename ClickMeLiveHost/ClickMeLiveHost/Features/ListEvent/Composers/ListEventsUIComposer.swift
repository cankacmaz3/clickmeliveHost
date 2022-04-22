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
        
        let authenticationTokenHeader = ["Token": "eyJ1c2VySWQiOjk1LCJ0eXBlIjoyLCJkZXZpY2VJZCI6MTk1LCJleHBpcmUiOiIyMDk5LTEyLTMxVDAwOjAwOjAwLjAwMFoiLCJ0aW1lIjoiMjAyMi0wNC0yMlQxNDoyNTowNi4zNThaIn0=.NDE1Njg4ZThlYmY1YWQ1ODBhNmY0OWM5MjIyYWJmMGY4MjE1MGQ5MmJmZjhlMjdiYTg2YjRlYzZhOThkZjg3MA=="]
       
        let eventLoader = RemoteEventLoader(client: loadingClient, baseURL: AppEnvironment.baseURL, authenticationTokenHeader: authenticationTokenHeader)
        let viewModel = ListEventsViewModel(eventLoader: eventLoader)
        let refreshController = ListEventsRefreshController(viewModel: viewModel)
        let listEventsViewController = ListEventsViewController(refreshController: refreshController)
        
        let router = ListEventsRouter()
        router.viewController = listEventsViewController
        
        listEventsViewController.display(categories: [
            EventCategoryCellController(viewModel: EventCategoryCellViewModel(status: .UPCOMING)),
            EventCategoryCellController(viewModel: EventCategoryCellViewModel(status: .ENDED)),
            EventCategoryCellController(viewModel: EventCategoryCellViewModel(status: .CANCELLED))
        ])
        
        viewModel.onEventsLoaded = { [weak listEventsViewController] events in
            listEventsViewController?.display(events.map { event in
                let viewModel = EventViewModel(model: event) {
                    router.openBroadcastModule()
                }
                return ListEventCellController(viewModel: viewModel)
            })
        }
        
        viewModel.onError = {
            print("failure")
        }
        
        return listEventsViewController
    }
}
