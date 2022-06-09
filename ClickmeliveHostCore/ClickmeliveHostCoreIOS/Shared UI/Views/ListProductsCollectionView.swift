//
//  ListProductsCollectionView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation
import UIKit
import ClickmeliveHostCore

extension ListProductsCollectionView {
    func setTitle(_ title: String) {
        lblTitle.text = title
    }
}

final class ListProductsCollectionView: UIView {
    
    private enum Constants {
        static let cellId: String = "\(ImageCell.self)"
        static let headerCellId: String = "\(ListProductsHeaderCell.self)"
    }
    
    public var onAddProductTapped: (([ProductViewModel]) -> Void)?
    
    private var products: [ProductViewModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryText
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func display(products: [ProductViewModel]) {
        self.products = products
    }
    
    public func selectedProductIds() -> [Int] {
        return self.products?.map { $0.id } ?? []
    }
    
    private func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: Constants.cellId)
        collectionView.register(ListProductsHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerCellId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(lblTitle)
        addSubview(collectionView)
    }
    
    private func setupLayout() {
        lblTitle.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        collectionView.anchor(lblTitle.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 114)
    }
    
    @objc private func headerTapped() {
        onAddProductTapped?(products ?? [])
    }
}

extension ListProductsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! ImageCell
       
        if let image = products?[indexPath.item].image {
            cell.configure(image: image)
        }
        
        cell.onDeleteTapped = { [weak self] in
            self?.products?.remove(at: indexPath.item)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 114, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerCellId, for: indexPath) as! ListProductsHeaderCell
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        view.addGestureRecognizer(gesture)
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 130, height: collectionView.frame.height)
    }
}

class ListProductsHeaderCell: UICollectionReusableView {
    
    private enum Constants {
        static let selectProductImage: String = "img_select_product"
    }
    
    // MARK: - View inits
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.selectProductImage,
                                  in: Bundle(for: ListProductsHeaderCell.self),
                                  compatibleWith: nil)
        return imageView
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        
        addSubview(imageView)
        imageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 114, heightConstant: 0)
        
    }
}

