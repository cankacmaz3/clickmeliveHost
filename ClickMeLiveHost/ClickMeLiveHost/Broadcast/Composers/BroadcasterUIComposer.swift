//
//  BroadcasterUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class BroadcasterUIComposer {
    private init() {}
    
    static func makeBroadcastViewController() -> BroadcastViewController {
        return BroadcastViewController()
    }
}
