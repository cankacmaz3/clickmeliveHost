//
//  Layouting.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import UIKit

/// Conform to `Layouting` in `UIViewController` that layouts a `Layoutable` `UIView`
public protocol Layouting: AnyObject {

    /// `Layoutable` view type
    associatedtype ViewType: UIView & Layoutable

    /// view as a `Layoutable` view type.
    var layoutableView: ViewType { get }
}

extension Layouting where Self: UIViewController {

    /// view as a `Layoutable` view type.
    public var layoutableView: ViewType {
        guard let aView = view as? ViewType else {
            fatalError("view property has not been initialized yet, or not initialized as \(ViewType.self).")
        }
        return aView
    }

    
}
