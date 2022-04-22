//
//  ViewerViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public final class ViewerViewModel {
    public typealias Observer<T> = (T) -> Void
    
    private let viewerListener: ViewerListener
    
    public init(viewerListener: ViewerListener) {
        self.viewerListener = viewerListener
    }
    
    public var onMessageReceived: Observer<Int>?
    
    public func listenViewerUpdates(eventId: Int) {
        viewerListener.connect(eventId: eventId) { [weak self] result in
            switch result {
            case let .success(viewerCount):
                self?.onMessageReceived?(viewerCount)
            case .failure:
                print("error")
            }
        }
    }
    
    public func removeViewerListener() {
        viewerListener.disconnect()
    }
}
