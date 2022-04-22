//
//  Double+Extensions.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

extension Double {
    func priceFormat() -> String {
        return String(format: "%.2f TL", self).replacingOccurrences(of: ".", with: ",")
    }
}
