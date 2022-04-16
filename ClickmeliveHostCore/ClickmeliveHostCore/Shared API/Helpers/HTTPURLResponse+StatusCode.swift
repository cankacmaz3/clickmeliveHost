//
//  HTTPURLResponse+StatusCode.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation

extension HTTPURLResponse {
    var isOK: Bool {
        return (200...299).contains(self.statusCode)
    }
}
