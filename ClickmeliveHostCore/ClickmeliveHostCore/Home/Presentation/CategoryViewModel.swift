//
//  CategoryViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 24.05.2022.
//

import Foundation

public final class CategoryViewModel {
    
    private let contentType: ContentType
   
    public init(contentType: ContentType) {
        self.contentType = contentType
    }
   
    public var localizedTitle: String? {
        switch contentType {
        case .live:
            return "Yayınlar"
        case .video:
            return "Videolar"
        }
    }
}
