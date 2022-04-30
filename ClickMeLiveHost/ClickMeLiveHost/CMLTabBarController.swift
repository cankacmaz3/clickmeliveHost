//
//  CMLTabbarController.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 30.04.2022.
//

import UIKit

final class CMLTabBarController: UITabBarController {
    
    private enum Constants {
        static let tabbarSelectedColor: UIColor = UIColor.rgb(red: 54, green: 71, blue: 81)
        static let tabbarUnselectedColor: UIColor = UIColor.rgb(red: 221, green: 226, blue: 229)
    }
    
    var customTabBarView = UIView(frame: .zero)
        
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarUI()
        self.addCustomTabBarView()
    }
    
    private func setupTabBarUI() {
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = Constants.tabbarSelectedColor
        self.tabBar.unselectedItemTintColor = Constants.tabbarUnselectedColor
    }
    
    private func addCustomTabBarView() {
        self.customTabBarView.frame = tabBar.frame
        
        self.customTabBarView.backgroundColor = .white
     
        self.customTabBarView.layer.masksToBounds = false
        self.customTabBarView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.customTabBarView.layer.shadowOffset = .zero
        self.customTabBarView.layer.shadowOpacity = 0.5
        self.customTabBarView.layer.shadowRadius = 10
        
        self.view.addSubview(customTabBarView)
        self.view.bringSubviewToFront(self.tabBar)
    }
}

