//
//  VirtualViewerDTO.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

struct VirtualViewerDTO: Codable {
    var stats: ViewersCountStats?
    
    struct ViewersCountStats: Codable {
        let viewers: Viewers?
    }
    
    struct Viewers: Codable {
        let virtualViewer: Int?
    }
}
