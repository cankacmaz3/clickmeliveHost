//
//  ContentView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit
import WSTagsField
import ClickmeliveHostCore

extension ContentView {
    func populate(with viewModel: EventViewModel) {
        tfVideoName.text = viewModel.title
    }
    
    func setLocalizedTitles(viewModel: ContentViewModel) {
        listProductsView.setTitle(viewModel.addPhoto)
        lblVideoName.text = viewModel.videoName
        tfVideoName.attributedPlaceholder = NSAttributedString(
            string: viewModel.videoNamePlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.primaryPlaceholderText,
                         NSAttributedString.Key.font: UIFont(name: Fonts.regular, size: 14)!])
        
        lblLivestreamTitle.text = viewModel.streamTitle
        tfLivestreamTitle.attributedPlaceholder = NSAttributedString(
            string: viewModel.streamTitlePlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.primaryPlaceholderText,
                         NSAttributedString.Key.font: UIFont(name: Fonts.regular, size: 14)!])
        
        lblTags.text = viewModel.tags
        tfTags.placeholder = viewModel.tagsPlaceholder
        
        groupsPickerView.lblGroups.text = viewModel.group
        groupsPickerView.tfGroups.attributedPlaceholder = NSAttributedString(
            string: viewModel.groupPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.primaryPlaceholderText,
                         NSAttributedString.Key.font: UIFont(name: Fonts.regular, size: 14)!])
        
        categoriesPickerView.lblCategories.text = viewModel.category
        categoriesPickerView.tfCategories.attributedPlaceholder = NSAttributedString(
            string: viewModel.categoryPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.primaryPlaceholderText,
                         NSAttributedString.Key.font: UIFont(name: Fonts.regular, size: 14)!])
        
        btnApprove.setTitle(viewModel.approve, for: .normal)
    }
    
    func setupContent(type: CMLContentType) {
        switch type {
        case .video:
            [lblVideoName, tfVideoName].forEach {
                videoNameStackView.addArrangedSubview($0)
            }
            
            [videoNameStackView, categoriesPickerView].forEach {
                stackView.addArrangedSubview($0, withMargin: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16))
            }
            
            tfVideoName.constrainHeight(50)
            
        case .livestream:
            [lblLivestreamTitle, tfLivestreamTitle].forEach {
                livestreamTitleStackView.addArrangedSubview($0)
            }
            
            [livestreamTitleStackView, groupsPickerView, startingDateView].forEach {
                stackView.addArrangedSubview($0, withMargin: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16))
            }
            
            tfLivestreamTitle.constrainHeight(50)
        }
        
        [lblTags, tfTags].forEach {
            tagsStackView.addArrangedSubview($0)
        }
        
        stackView.addArrangedSubview(tagsStackView, withMargin: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16))
        stackView.addArrangedSubview(addVideoView)
        stackView.addArrangedSubview(listProductsView)
        
        stackView.addArrangedSubview(btnApprove, withMargin: UIEdgeInsets(top: 0, left: 16, bottom: -16, right: -16))
        btnApprove.constrainHeight(50)
    }
    
}

public final class ContentView: UIView, Layoutable {
    
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
    
    private let livestreamTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let lblLivestreamTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryText
        return label
    }()
    
    let tfLivestreamTitle: UITextField = {
        let tf = CMLTextField(padding: 15,
                              font: UIFont(name: Fonts.regular, size: 14)!,
                              cornerRadius: 4)
        
        return tf
    }()
    
    let categoriesPickerView: CategoryPickerView = {
        let view = CategoryPickerView()
        return view
    }()
    
    let groupsPickerView: GroupPickerView = {
        let view = GroupPickerView()
        return view
    }()
    
    let startingDateView: StartingDateView = {
        let view = StartingDateView()
        return view
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
        
        scrollView.addSubview(stackView)
    }
    
    public func setupLayout() {
        scrollView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        stackView.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0))
    }
}
