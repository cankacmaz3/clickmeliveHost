//
//  EmptyView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 23.04.2022.
//

import Foundation
import UIKit

extension PlaceholderView {
    func setImageConstraints(imageWidth: CGFloat, imageHeight: CGFloat) {
        ivPlaceholder.constrainWidth(imageWidth)
        ivPlaceholder.constrainHeight(imageHeight)
    }
    
    func setImage(image: String) {
        ivPlaceholder.image = UIImage(named: image,
                                      in: Bundle(for: PlaceholderView.self),
                                      compatibleWith: nil)
    }
    
    func setTitle(_ title: String?) {
        lblPlaceholder.text = title
    }
}

final class PlaceholderView: UIView {
    
    private enum Constants {
        static let backgroundColor: UIColor = Colors.primaryBg
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 40
        return stackView
    }()
    
    private let ivPlaceholder: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let lblPlaceholder: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.medium, size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.primaryText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = Constants.backgroundColor
        
        [ivPlaceholder, lblPlaceholder].forEach {
            addSubview($0)
        }
    }
    
    private func setupLayout() {
        ivPlaceholder.anchorCenterYToSuperview(constant: -50)
        ivPlaceholder.anchorCenterXToSuperview()
        
        lblPlaceholder.anchor(ivPlaceholder.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 40, leftConstant: 43, bottomConstant: 0, rightConstant: 43, widthConstant: 0, heightConstant: 0)
    }
}
