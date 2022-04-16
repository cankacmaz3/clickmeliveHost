//
//  Layoutable.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import UIKit

public protocol Layoutable: AnyObject {

    /// Setup the view and it's subviews here.
    func setupViews()

    /// Add layout code here.
    func setupLayout()
}

extension Layoutable where Self: UIView {

    /// - Returns: `self`
    static func create() -> Self {
        let view = Self()
        view.setupViews()
        view.setupLayout()
        return view
    }
}

