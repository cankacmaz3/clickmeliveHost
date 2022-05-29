//
//  ListVideosView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 25.05.2022.
//

import Foundation
import UIKit
import ClickmeliveHostCore

final public class ListVideosView: UIView, Layoutable {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
       
        return cv
    }()
    
    public func setupViews() {
        backgroundColor = .white
        addSubview(collectionView)
    }
    
    public func setupLayout() {
        collectionView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

