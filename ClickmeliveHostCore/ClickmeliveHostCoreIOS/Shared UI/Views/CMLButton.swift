//
//  CMLButton.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation
import UIKit

class CMLButton: UIButton {
    
    private enum Constants {
        static let bgColor: UIColor = Colors.primary
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, enabled: Bool = true) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        
        handleIsEnabled(enabled)
    }
    
    private func configure() {
        layer.cornerRadius = 5
        backgroundColor = Constants.bgColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: Fonts.bold, size: 16)
    }
    
    func handleIsEnabled(_ enabled: Bool) {
        if enabled {
            self.isUserInteractionEnabled = true
            backgroundColor = Constants.bgColor
        } else {
            self.isUserInteractionEnabled = false
            backgroundColor = Constants.bgColor.withAlphaComponent(0.4)
        }
    }
}
