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
        
        let authenticationTokenHeader = ["Token": "eyJ1c2VySWQiOjEwMCwidHlwZSI6MiwiZGV2aWNlSWQiOjIwMSwiZXhwaXJlIjoiMjA5OS0xMi0zMVQwMDowMDowMC4wMDBaIiwidGltZSI6IjIwMjEtMTAtMTdUMTM6NTk6MTEuNzQ3WiJ9.ODlkOWUwMDZmYzQ2ZjlkYTQxZDcyOWU4Mzg4YzJiMDZmZjkwZjU3YWQwZDk1YjliZGQyZTc2MWE5NzBjZWI4ZA=="]
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
