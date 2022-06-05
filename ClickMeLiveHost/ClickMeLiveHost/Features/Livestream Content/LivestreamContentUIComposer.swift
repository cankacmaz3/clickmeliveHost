//
//  LivestreamContentUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class LivestreamContentUIComposer {
    private init() {}
    
    static func makeLivestreamContentViewController() -> LivestreamContentViewController {
        let controller = LivestreamContentViewController()
        return controller
    }
}
