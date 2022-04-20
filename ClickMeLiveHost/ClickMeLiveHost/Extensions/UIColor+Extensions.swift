//
//  UIColor+Extensions.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
