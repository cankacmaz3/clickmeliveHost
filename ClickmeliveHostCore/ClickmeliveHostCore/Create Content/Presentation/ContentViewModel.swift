//
//  ContentViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation

public final class ContentViewModel {
    
    public let contentType: CMLContentType
    public let select: () -> Void
    
    public init(contentType: CMLContentType,
                selection: @escaping () -> Void) {
        self.contentType = contentType
        self.select = selection
    }
    
    public var getLocalizedTitle: String {
        switch contentType {
        case .livestream:
            return Localized.CreateContent.livestream
        case .video:
            return Localized.CreateContent.video
        }
    }
  
}
