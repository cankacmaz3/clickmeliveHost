//
//  SDImageLoader.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation
import ClickmeliveHostCoreIOS
import SDWebImage

final class SDImageLoader: ImageLoader {
    func loadImage(to imageView: UIImageView, with url: URL?) {
        imageView.sd_imageTransition = .fade
        imageView.sd_setImage(with: url, completed: nil)
    }
}
