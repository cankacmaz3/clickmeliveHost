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
        let authenticationTokenHeader = ["Token": "eyJ1c2VySWQiOjEwMCwidHlwZSI6MiwiZGV2aWNlSWQiOjIwMSwiZXhwaXJlIjoiMjA5OS0xMi0zMVQwMDowMDowMC4wMDBaIiwidGltZSI6IjIwMjEtMTAtMTdUMTM6NTk6MTEuNzQ3WiJ9.ODlkOWUwMDZmYzQ2ZjlkYTQxZDcyOWU4Mzg4YzJiMDZmZjkwZjU3YWQwZDk1YjliZGQyZTc2MWE5NzBjZWI4ZA=="]
        let eventLoader = RemoteEventLoader(client: client, authenticationTokenHeader: authenticationTokenHeader)
        let viewModel = ListEventsViewModel(eventLoader: eventLoader)
        let refreshController = ListEventsRefreshController(viewModel: viewModel)
        let listEventsViewController = ListEventsViewController(refreshController: refreshController)
        
        viewModel.onEventsLoaded = { [weak listEventsViewController] events in
            listEventsViewController?.display(events.map { event in
                let viewModel = EventViewModel(model: event) {
                    print("Selected here \(event)")
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
