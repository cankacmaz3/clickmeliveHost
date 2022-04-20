//
//  LoadingViewHTTPClientDecorator.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation
import ClickmeliveHostCore

class LoadingViewHTTPClientDecorator: HTTPClient {
    
    private let decoratee: HTTPClient
    private let loadingView: LoadingView
    
    init(decoratee: HTTPClient, loadingView: LoadingView) {
        self.decoratee = decoratee
        self.loadingView = loadingView
    }
    
    func execute(with request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        loadingView.showLoading()
        return decoratee.execute(with: request) { [weak self] result in
            self?.loadingView.hideLoading()
            completion(result)
        }
    }
}
