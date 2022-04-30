//
//  CMLNavigationController.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import UIKit

class CMLNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        // Setup interactivePopGestureRecognizer
        if let interactivePopGestureRecognizer = self.interactivePopGestureRecognizer {
            interactivePopGestureRecognizer.delegate = nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            if viewControllers.count > 1 {
                self.interactivePopGestureRecognizer?.isEnabled = true
            } else {
                self.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
    }
}
