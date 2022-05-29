//
//  HomeUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 24.05.2022.
//

import Foundation
import ClickmeliveHostCoreIOS
import UIKit

final class HomeUIComposer {
    private init() {}
    
    static func makeHomeViewController() -> HomeViewController {
        let homeRouter = HomeRouter()
        
        let listEventsViewController = ListEventsUIComposer.makeListEventsController(router: homeRouter)
        
        let listVideosViewController = ListVideoUIComposer.makeListVideosViewController(router: homeRouter)
        
        let controller = HomeViewController(listEventsViewController: listEventsViewController,
                                            listVideosViewController: listVideosViewController)
        homeRouter.viewController = controller
        
        return controller
    }
}
