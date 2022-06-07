//
//  Localized+Stock.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation

extension Localized {
    enum Stock {
        static var table: String { "Stock" }

        static var remainingStock: String {
            NSLocalizedString(
                "STOCK_ITEM_REMAINING_STOCK",
                tableName: table,
                bundle: bundle,
                comment: "Title for remaining stock")
        }
        
        static var soldOut: String {
            NSLocalizedString(
                "STOCK_ITEM_SOLD_OUT",
                tableName: table,
                bundle: bundle,
                comment: "Title for sold out")
        }
        
        static var count: String {
            NSLocalizedString(
                "STOCK_COUNT",
                tableName: table,
                bundle: bundle,
                comment: "Title for stock count")
        }
    }
}

