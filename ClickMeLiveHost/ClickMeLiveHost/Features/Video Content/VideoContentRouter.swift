//
//  VideoContentRouter.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation
import ClickmeliveHostCoreIOS

final class VideoContentRouter: Router<VideoContentViewController>, VideoContentRouter.Routes {
    typealias Routes = ListProductRoute
    var listProductTransition: Transition = PushTransition()
}


