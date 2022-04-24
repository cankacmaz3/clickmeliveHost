//
//  Int+Extensions.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 24.04.2022.
//

import Foundation

extension Int {
    func formatSecondsToTimeString() -> String {
        let h: Int = self / 3600
        let m: Int = (self / 60) % 60
        let s: Int = self % 60
        var time = String(format: " %2u:%02u  ", m, s)
        if h > 0 {
            time = String(format: " %u:%02u:%02u  ", h, m, s)
        }
        return time
    }
}
