//
//  ProductCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import UIKit
import ClickmeliveHostCore

extension ProductCell {
    func configure(with viewModel: ProductViewModel, at index: Int) {
        setProductImage(image: viewModel.image)
        lblProductName.text = viewModel.name
        lblPrice.text = viewModel.price
        lblDiscountedPrice.attributedText = viewModel.discountedPrice?.strikeThrough()
        lblIndex.text = "\(index)"
    }
    
    private func setProductImage(image: String?) {
        guard let image = image else { return }
        ivProduct.sd_imageTransition = .fade
        ivProduct.sd_setImage(with: URL(string: image), completed: nil)
    }
}

final class ProductCell: UICollectionViewCell {
    
    private enum Constants {
        static let itemIndexViewColor: UIColor = UIColor.rgb(red: 221, green: 226, blue: 229)
    }
    
    private let lblProductName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 14)
        label.textColor = .white
        label.UILabelTextShadow()
        return label
    }()
    
    private let productView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let ivProduct: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let lblPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.UILabelTextShadow()
        return label
    }()
    
    private let lblDiscountedPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.medium, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.UILabelTextShadow()
        return label
    }()
    
    private let itemIndexView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.cornerRadius = 8
        view.backgroundColor = Constants.itemIndexViewColor
        return view
    }()
    
    private let lblIndex: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.UILabelTextShadow()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        [lblProductName, productView, lblPrice, lblDiscountedPrice].forEach {
            contentView.addSubview($0)
        }
        
        itemIndexView.addSubview(lblIndex)
        [ivProduct, itemIndexView].forEach {
            productView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        lblProductName.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        productView.anchor(lblProductName.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 70)
        
        ivProduct.fillSuperview()
        
        lblPrice.anchor(productView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        lblDiscountedPrice.anchor(lblPrice.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        lblIndex.fillSuperview()
        itemIndexView.anchor(productView.topAnchor, left: productView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 24, heightConstant: 24)
    }
}
