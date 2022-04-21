//
//  LandingView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import UIKit

extension LandingView {
    func setButtonTitle(_ title: String) {
        btnLogin.setTitle(title, for: .normal)
    }
}

public final class LandingView: UIView, Layoutable {
    
    private enum Constants {
        static let bgImage: String = "img_landing"
        static let buttonTitleColor: UIColor = Colors.primary
    }
    
    private let ivBg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.bgImage,
                                  in: Bundle(for: LandingView.self),
                                  compatibleWith: nil)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let btnLogin: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(Constants.buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: Fonts.bold, size: 16)
        return button
    }()
    
    public func setupViews() {
        backgroundColor = .white
        
        addSubview(ivBg)
        addSubview(btnLogin)
    }
    
    public func setupLayout() {
        ivBg.fillSuperview()
        btnLogin.anchor(nil, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 50)
    }
}
