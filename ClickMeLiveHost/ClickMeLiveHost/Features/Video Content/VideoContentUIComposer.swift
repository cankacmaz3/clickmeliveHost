//
//  VideoContentUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation
import Combine
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class VideoContentUIComposer {
    private init() {}
    
    private static var disposables = Set<AnyCancellable>()
    
    static func makeVideoContentViewController() -> VideoContentViewController {
        let router = VideoContentRouter()
        
        let controller = VideoContentViewController()
        router.viewController = controller
        
        
        controller.onAddProductSelected.sink(receiveValue: { productViewModels in
            router.openListProductModule(selectedProducts: productViewModels, delegate: controller)
        }).store(in: &disposables)
        
        return controller
    }
}


