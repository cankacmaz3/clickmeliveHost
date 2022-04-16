//
//  ListEventsView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation
import UIKit

final public class ListEventsView: UIView, Layoutable {
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .red
        
        return cv
    }()
    
    let listEventsTableView: UITableView = {
        let tv = UITableView(frame: .zero)
        
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .white
        
        return tv
    }()
    
    public func setupViews() {
        backgroundColor = .white
        
        addSubview(categoryCollectionView)
        addSubview(listEventsTableView)
    }
    
    public func setupLayout() {
        categoryCollectionView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 44)
        
        listEventsTableView.anchor(categoryCollectionView.bottomAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
