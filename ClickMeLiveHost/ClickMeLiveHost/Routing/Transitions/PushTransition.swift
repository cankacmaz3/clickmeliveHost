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
    var hidesBottomBarWhenPushed: Bool = false
    
    weak var viewController: UIViewController?

    init(isAnimated: Bool = true,
         hidesBottomBarWhenPushed: Bool = false) {
        self.isAnimated = isAnimated
        self.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
    }
}

// MARK: - Transition
extension PushTransition: Transition {

    func open(_ viewController: UIViewController) {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: Constants.backImage), style: .done, target: self, action: #selector(close))
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    @objc func close(_ viewController: UIViewController) {
        self.viewController?.navigationController?.popViewController(animated: isAnimated)
    }
}
