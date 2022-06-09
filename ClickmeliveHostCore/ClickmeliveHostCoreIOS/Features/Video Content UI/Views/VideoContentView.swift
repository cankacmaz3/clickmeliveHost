//
//  VideoContentView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit
import WSTagsField
import ClickmeliveHostCore

extension VideoContentView {
    func setLocalizedTitles(viewModel: VideoContentViewModel) {
        listProductsView.setTitle(viewModel.addPhoto)
        lblVideoName.text = viewModel.videoName
        tfVideoName.attributedPlaceholder = NSAttributedString(
            string: viewModel.videoNamePlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.primaryPlaceholderText,
                         NSAttributedString.Key.font: UIFont(name: Fonts.regular, size: 14)!])
        lblTags.text = viewModel.tags
        tfTags.placeholder = viewModel.tagsPlaceholder
        
        lblCategories.text = viewModel.category
        tfCategories.attributedPlaceholder = NSAttributedString(
            string: viewModel.categoryPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.primaryPlaceholderText,
                         NSAttributedString.Key.font: UIFont(name: Fonts.regular, size: 14)!])
        tfCategories.inputView = pickerView
        
        btnApprove.setTitle(viewModel.approve, for: .normal)
    }
    
    
}

public final class VideoContentView: UIView, Layoutable {
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .clear
        return sv
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()
    
    private let videoNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let lblVideoName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryText
        return label
    }()
    
    let tfVideoName: UITextField = {
        let tf = CMLTextField(padding: 15,
                              font: UIFont(name: Fonts.regular, size: 14)!,
                              cornerRadius: 4)
        
        return tf
    }()
    
    private let categoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let lblCategories: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryText
        return label
    }()
    
    let tfCategories: UITextField = {
        let tf = CMLTextField(padding: 15,
                              font: UIFont(name: Fonts.regular, size: 14)!,
                              cornerRadius: 4)
        tf.keyboardToolbar.doneBarButton.tintColor = Colors.primary
        tf.keyboardToolbar.doneBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.primary,
                                                                        NSAttributedString.Key.font: UIFont(name: Fonts.medium, size: 14)!], for: UIControl.State.normal)
        return tf
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    private let tagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let lblTags: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryText
        return label
    }()
    
    let tfTags: WSTagsField = {
        let tf = WSTagsField()
        tf.acceptTagOption = .comma
        tf.tintColor = Colors.primary.withAlphaComponent(0.4)
        tf.textColor = Colors.primary
        tf.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tf.contentInset = UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 3)
        tf.spaceBetweenLines = 5.0
        tf.spaceBetweenTags = 10.0
        return tf
    }()
    
    let addVideoView: AddVideoView = {
        let view = AddVideoView()
        return view
    }()
    
    let listProductsView: ListProductsCollectionView = {
        let view = ListProductsCollectionView()
        return view
    }()
    
    let btnApprove: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.primary
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.bold, size: 16)
        button.layer.cornerRadius = 5
        return button
    }()
    
    public func setupViews() {
        backgroundColor = .white
        addSubview(scrollView)
        
        [lblVideoName, tfVideoName].forEach {
            videoNameStackView.addArrangedSubview($0, withMargin: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16))
        }
        
        [lblCategories, tfCategories].forEach {
            categoriesStackView.addArrangedSubview($0, withMargin: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16))
        }
        
        [lblTags, tfTags].forEach {
            tagsStackView.addArrangedSubview($0, withMargin: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16))
        }
        
        [videoNameStackView, categoriesStackView, tagsStackView, addVideoView, listProductsView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.addArrangedSubview(btnApprove, withMargin: UIEdgeInsets(top: 0, left: 16, bottom: -16, right: -16))
        
        scrollView.addSubview(stackView)
    }
    
    public func setupLayout() {
        scrollView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        stackView.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0))
        
        tfVideoName.constrainHeight(50)
        tfCategories.constrainHeight(50)
        
        btnApprove.constrainHeight(50)
    }
}

