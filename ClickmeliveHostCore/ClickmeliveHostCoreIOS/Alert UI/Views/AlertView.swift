//
//  AlertView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import UIKit

extension AlertView {
    func setTitles(messageTitle: String, buttonTitle: String) {
        lblTitle.text = messageTitle
        btnAction.setTitle(buttonTitle, for: .normal)
    }
}

public final class AlertView: UIView, Layoutable {
    
    private enum Constants {
        static let bgColor: UIColor = .black.withAlphaComponent(0.1)
        static let actionButtonColor: UIColor = Colors.primary
        static let titleColor: UIColor = Colors.primaryText
        static let closeImage: String = "icon_close"
    }
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.bgColor
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 5
        view.layer.masksToBounds =  false
        view.layer.cornerRadius = 16
        return view
    }()
    
    let closeView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let ivClose: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.closeImage,
                                  in: Bundle(for: AlertView.self),
                                  compatibleWith: nil)
        return imageView
    }()
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.regular, size: 16)
        label.numberOfLines = 0
        label.textColor = Constants.titleColor
        label.textAlignment = .center
        return label
    }()
    
    let btnAction: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.actionButtonColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.bold, size: 16)
        button.layer.cornerRadius = 4
        return button
    }()
    
    public func setupViews() {
        backgroundColor = .clear
        
        addSubview(contentView)
        
        closeView.addSubview(ivClose)
        
        [closeView, btnAction, lblTitle].forEach {
            alertView.addSubview($0)
        }
        
        addSubview(alertView)
    }
    
    public func setupLayout() {
        contentView.fillSuperview()
        alertView.anchor(nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 0)
        alertView.anchorCenterYToSuperview()
        
        closeView.anchor(alertView.topAnchor, left: nil, bottom: nil, right: alertView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 35, heightConstant: 35)
        
        ivClose.anchor(closeView.topAnchor, left: nil, bottom: nil, right: closeView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 12, heightConstant: 12)
        
        btnAction.anchor(nil, left: alertView.leftAnchor, bottom: alertView.bottomAnchor, right: alertView.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 24, rightConstant: 20, widthConstant: 0, heightConstant: 38)
        
        lblTitle.anchor(closeView.bottomAnchor, left: alertView.leftAnchor, bottom: btnAction.topAnchor, right: alertView.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 40, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        
    }
}
