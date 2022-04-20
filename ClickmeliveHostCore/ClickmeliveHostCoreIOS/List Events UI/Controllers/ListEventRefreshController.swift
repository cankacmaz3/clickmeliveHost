//
//  ListEventRefreshController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import UIKit
import ClickmeliveHostCore

public final class ListEventsRefreshController: NSObject {
    private(set) lazy var view = binded(UIRefreshControl())
      
    private let viewModel: ListEventsViewModel
    
    public init(viewModel: ListEventsViewModel) {
        self.viewModel = viewModel
    }
    
    @objc public func refresh() {
        viewModel.loadEvents(with: .LONG_VIDEO)
    }
    
    public func onNext() {
        viewModel.onNextEvent()
    }
    
    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel.onEventsLoadingStateChange = { [weak view] isLoading in
            if !isLoading {
                view?.endRefreshing()
            }
        }
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
