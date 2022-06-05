//
//  VideoContentUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class VideoContentUIComposer {
    private init() {}
    
    static func makeVideoContentViewController() -> VideoContentViewController {
        let controller = VideoContentViewController()
        return controller
    }
}


