//
//  Metadata.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation

struct Metadata: Decodable {
    let pageNumber: Int
    let pageSize: Int
    let totalRecordCount: Int
}
