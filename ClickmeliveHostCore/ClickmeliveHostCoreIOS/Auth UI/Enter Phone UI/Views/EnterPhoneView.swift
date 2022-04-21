//
//  EnterPhoneView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import UIKit
import ClickmeliveHostCore

extension EnterPhoneView {
    func setLocalizedTitles(with viewModel: EnterPhoneViewModel) {
        lblTitle.text = viewModel.title
        lblDetail.text = viewModel.detail
        tfValidate.setupPlaceholder(placeholder: viewModel.phonePlaceholder,
                                    font: UIFont(name: Fonts.regular, size: 16)!)
        btnValidate.setTitle(viewModel.sendCode, for: .normal)
    }
}

public final class EnterPhoneView: UIView, Layoutable {
    
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
        stackView.spacing = 38
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
    
    let tfValidate: CMLTextField = {
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
    
    let btnValidate: CMLButton = {
        let btn = CMLButton(title: "Localizable.btnSendCode", enabled: false)
        return btn
    }()
    
    public func setupViews() {
        backgroundColor = .white
        
        addSubview(btnValidate)
        
        addSubview(scrollView)
        
        [lblTitle, lblDetail, tfValidate].forEach {
            stackView.addArrangedSubview($0)
        }
        
        scrollView.addSubview(stackView)
    }
    
    public func setupLayout() {
        btnValidate.anchor(nil, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 24, rightConstant: 16, widthConstant: 0, heightConstant: 50)
        
        scrollView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: btnValidate.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tfValidate.constrainHeight(50)
        
        stackView.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 80, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -32))
    }
}

