//
//  ImageURLCreator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Combine
import Foundation

public protocol ImageURLCreator {
    func load(data: Data) -> AnyPublisher<UploadImage, Error>
}
