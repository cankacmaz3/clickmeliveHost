//
//  PushTransition.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import UIKit

class PushTransition: NSObject {

    var isAnimated: Bool = true
    var completionHandler: (() -> Void)?

    weak var viewController: UIViewController?

    init(isAnimated: Bool = true) {
        self.isAnimated = isAnimated
    }
}

// MARK: - Transition
extension PushTransition: Transition {

    func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    func close(_ viewController: UIViewController) {
        self.viewController?.navigationController?.popViewController(animated: isAnimated)
    }
}
