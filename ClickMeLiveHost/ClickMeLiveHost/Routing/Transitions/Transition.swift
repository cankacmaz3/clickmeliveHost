//
//  Transition.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import Foundation
import UIKit

protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }

    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}
