//
//  VideoContentView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit

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
    
    let listProductsView: ListProductsCollectionView = {
        let view = ListProductsCollectionView()
        return view
    }()
    
    public func setupViews() {
        backgroundColor = .white
        addSubview(scrollView)
        
        [listProductsView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        scrollView.addSubview(stackView)
    }
    
    public func setupLayout() {
        scrollView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        stackView.fillSuperview()
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0))
    }
}

