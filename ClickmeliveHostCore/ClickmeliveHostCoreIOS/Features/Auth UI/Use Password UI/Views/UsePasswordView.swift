//
//  UsePasswordView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.05.2022.
//

import UIKit
import ClickmeliveHostCore

extension UsePasswordView {
    func setLocalizedTitles(with viewModel: UsePasswordViewModel) {
        lblTitle.text = viewModel.title
        tfPhone.setupPlaceholder(placeholder: viewModel.phonePlaceholder,
                                    font: UIFont(name: Fonts.regular, size: 16)!)
        tfPassword.setupPlaceholder(placeholder: viewModel.passwordPlaceholder,
                                    font: UIFont(name: Fonts.regular, size: 16)!)
        btnLogin.setTitle(viewModel.login, for: .normal)
        btnUseSms.setTitle(viewModel.useSMS, for: .normal)
    }
}

public final class UsePasswordView: UIView, Layoutable {
    
    private enum Constants {
        static let titleColor: UIColor = Colors.primaryText
        static let detailColor: UIColor = Colors.primaryText
        static let validateTextFieldColor = Colors.primaryText
    }
    
    // MARK: - View inits
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .clear
        return sv
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 25
        stackView.axis = .vertical
        return stackView
    }()
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = Constants.titleColor
        label.font = UIFont(name: Fonts.semibold, size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let lblDetail: UILabel = {
        let label = UILabel()
        label.textColor = Constants.detailColor
        label.font = UIFont(name: Fonts.regular, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    let tfPhone: CMLTextField = {
        let tf = CMLTextField(padding: 19,
                              font: UIFont(name: Fonts.regular, size: 16)!,
                              cornerRadius: 4,
                              keyboardType: .decimalPad,
                              backgroundColor: .white,
                              centered: false,
                              withBorder: true)
        tf.textColor = Constants.validateTextFieldColor
        return tf
    }()
    
    let tfPassword: CMLTextField = {
        let tf = CMLTextField(padding: 19,
                              font: UIFont(name: Fonts.regular, size: 16)!,
                              cornerRadius: 4,
                              keyboardType: .decimalPad,
                              backgroundColor: .white,
                              centered: false,
                              withBorder: true)
        tf.textColor = Constants.validateTextFieldColor
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let btnLogin: CMLButton = {
        let btn = CMLButton()
        btn.handleIsEnabled(false)
        return btn
    }()
    
    let btnUseSms: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: Fonts.medium, size: 16)
        btn.setTitleColor(Colors.primaryText, for: .normal)
        return btn
    }()
    
    public func setupViews() {
        backgroundColor = .white
        
        addSubview(btnLogin)
        
        addSubview(scrollView)
        
        
        [lblTitle, tfPhone, tfPassword, btnUseSms].forEach {
            stackView.addArrangedSubview($0)
        }
        
        scrollView.addSubview(stackView)
    }
    
    public func setupLayout() {
        btnLogin.anchor(nil, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 24, rightConstant: 16, widthConstant: 0, heightConstant: 50)
        
        scrollView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: btnLogin.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tfPhone.constrainHeight(50)
        tfPassword.constrainHeight(50)
        
        stackView.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 80, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -32))
    }
}


