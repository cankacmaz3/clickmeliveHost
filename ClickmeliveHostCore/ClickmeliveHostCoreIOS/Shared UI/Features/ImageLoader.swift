//
//  ImageLoader.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import UIKit

public protocol ImageLoader {
    func loadImage(to imageView: UIImageView, with url: URL?)
}
