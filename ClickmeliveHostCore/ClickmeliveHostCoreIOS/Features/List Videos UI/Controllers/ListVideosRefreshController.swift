//
//  ListVideosRefreshController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import UIKit
import ClickmeliveHostCore

public final class ListVideosRefreshController: NSObject {
    private(set) lazy var view = binded(UIRefreshControl())
      
    private let viewModel: ListVideosViewModel
    
    public init(viewModel: ListVideosViewModel) {
        self.viewModel = viewModel
    }
    
    @objc public func refresh() {
        viewModel.loadVideos(status: [.SHORT_VIDEO, .LONG_VIDEO])
    }
    
    public func onNext() {
        viewModel.onNextEvent()
    }
    
    public func deleteEvent(eventId: Int) {
        viewModel.deleteEvent(eventId: eventId)
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
