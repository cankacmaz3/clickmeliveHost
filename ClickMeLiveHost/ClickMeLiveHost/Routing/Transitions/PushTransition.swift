//
//  PushTransition.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import UIKit

class PushTransition: NSObject {

    private enum Constants {
        static let backImage: String = "img_back"
    }
    
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
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: Constants.backImage), style: .done, target: self, action: #selector(close))
        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    @objc func close(_ viewController: UIViewController) {
        self.viewController?.navigationController?.popViewController(animated: isAnimated)
    }
}
