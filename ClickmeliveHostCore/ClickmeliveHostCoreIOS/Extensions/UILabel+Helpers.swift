//
//  UILabel+Helpers.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import UIKit

extension UILabel {
    public func UILabelTextShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowRadius = 0.5
        self.layer.shadowOpacity = 0.3
    }
}
