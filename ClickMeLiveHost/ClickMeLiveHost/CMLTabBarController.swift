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
    }
    
    private func setupTabBarUI() {
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = Constants.tabbarSelectedColor
        self.tabBar.unselectedItemTintColor = Constants.tabbarUnselectedColor
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.masksToBounds = false
    }
}

