//
//  ListVideosView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 25.05.2022.
//

import Foundation
import UIKit
import ClickmeliveHostCore

extension ListVideosView {
    func setLocalizedTitles(viewModel: ListVideosViewModel?) {
        placeholderView.setTitle(viewModel?.placeholderTitle)
    }
}

final public class ListVideosView: UIView, Layoutable {
    
    private enum Constants {
        static let placeholderImage: String = "img_placeholder_video"
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
       
        return cv
    }()
    
    let placeholderView: PlaceholderView = {
        let view = PlaceholderView()
        view.setImage(image: Constants.placeholderImage)
        view.setImageConstraints(imageWidth: 186, imageHeight: 188)
        view.isHidden = true
        return view
    }()
    
    public func setupViews() {
        backgroundColor = .white
        addSubview(placeholderView)
        addSubview(collectionView)
    }
    
    public func setupLayout() {
        placeholderView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        collectionView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

