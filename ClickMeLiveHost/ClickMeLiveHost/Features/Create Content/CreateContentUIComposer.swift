//
//  CreateContentUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 2.06.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class CreateContentUIComposer {
    private init() {}
    
    static func makeCreateContentViewController() -> CreateContentViewController {
        let router = CreateContentRouter()
        let viewModel = CreateContentViewModel()
        let controller = CreateContentViewController(viewModel: viewModel)
        router.viewController = controller
        
        controller.display(contents: [
            SelectContentViewModel(contentType: .livestream,
                             selection: {
                                 router.openContentModule(contentType: .livestream)
                            }
            ),
            SelectContentViewModel(contentType: .video,
                             selection: {
                                 router.openContentModule(contentType: .video)
                             }
            )
        ])
        
        return controller
    }
}

