//
//  Localized+ListProducts.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 7.06.2022.
//

import Foundation

extension Localized {
    enum ListProducts {
        static var table: String { "ListProducts" }

        static var navigationTitle: String {
            NSLocalizedString(
                "LIST_PRODUCTS_SELECTION_COUNT",
                tableName: table,
                bundle: bundle,
                comment: "Title for navigation")
        }
        
        static var save: String {
            NSLocalizedString(
                "LIST_PRODUCTS_SAVE",
                tableName: table,
                bundle: bundle,
                comment: "Title for save button")
        }
        
        static var searchPlaceholder: String {
            NSLocalizedString(
                "LIST_PRODUCTS_SEARCH_PLACEHOLDER",
                tableName: table,
                bundle: bundle,
                comment: "Title for searchbar placeholder")
        }
        
        static var exceededMaximumProductAlert: String {
            NSLocalizedString(
                "LIST_PRODUCTS_MAXIMUM_PRODUCT_EXCEEDED_ALERT",
                tableName: table,
                bundle: bundle,
                comment: "Title for exceeded maximum product count alert")
        }
    }
}

