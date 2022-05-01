//
//  ListEventsView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation
import UIKit
import ClickmeliveHostCore

extension ListEventsView {
    func setPlaceholderContent(title: String?, status: Event.EventStatus?) {
        placeholderView.setTitle(title)
        
        switch status {
        case .UPCOMING:
            placeholderView.setImage(image: Constants.placeholderUpcomingImage)
        case .ENDED:
            placeholderView.setImage(image: Constants.placeholderEndedImage)
        case .CANCELLED:
            placeholderView.setImage(image: Constants.placeholderCancelledImage)
        default:
            break
        }
    }
}

final public class ListEventsView: UIView, Layoutable {
    
    private enum Constants {
        static let placeholderUpcomingImage: String = "img_placeholder_upcoming"
        static let placeholderEndedImage: String = "img_placeholder_ended"
        static let placeholderCancelledImage: String = "img_placeholder_cancelled"
    }
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
       
        return cv
    }()

    let listEventsTableView: UITableView = {
        let tv = UITableView(frame: .zero)
        
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .clear
        
        return tv
    }()
    
    let placeholderView: PlaceholderView = {
        let view = PlaceholderView()
        view.setImageConstraints(imageWidth: 186, imageHeight: 188)
        view.isHidden = true
        return view
    }()
    
    public func setupViews() {
        backgroundColor = .white
        
        addSubview(categoryCollectionView)
        addSubview(placeholderView)
        addSubview(listEventsTableView)
    }
    
    public func setupLayout() {
        categoryCollectionView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        listEventsTableView.anchor(categoryCollectionView.bottomAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        placeholderView.anchor(categoryCollectionView.bottomAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
