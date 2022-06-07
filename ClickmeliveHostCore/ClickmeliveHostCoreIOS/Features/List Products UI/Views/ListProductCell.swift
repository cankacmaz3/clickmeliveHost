//
//  ListProductCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 7.06.2022.
//

import UIKit
import ClickmeliveHostCore

extension ListProductCell {
    func configure(with viewModel: ProductViewModel, imageLoader: ImageLoader, isSelected: Bool) {
        imageLoader.loadImage(to: ivProduct, with: viewModel.imageURL)
        
        lblProductName.text = viewModel.name
        lblPrice.text = viewModel.price
        lblDiscountedPrice.attributedText = viewModel.discountedPrice?.strikeThrough()
        lblStock.text = viewModel.stockQuantity
        
        checkBox.setChecked(to: isSelected)
    }
}

final class ListProductCell: UITableViewCell {
    
    private let checkBox: CMLCheckbox = {
        let view = CMLCheckbox()
        return view
    }()
    
    private let ivProduct: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.layer.borderWidth = 1.0
        iv.layer.borderColor = UIColor.rgb(red: 221, green: 226, blue: 229).cgColor
        
        return iv
    }()
    
    private let lblProductName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 14)
        label.textColor = Colors.primaryText
        return label
    }()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private let lblPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.bold, size: 16)
        label.textColor = Colors.primary
        return label
    }()
    
    private let lblDiscountedPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 16)
        label.textColor = UIColor.rgb(red: 179, green: 179, blue: 179)
        return label
    }()
    
    private let lblStock: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.regular, size: 12)
        label.textColor = Colors.primaryText
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(checkBox)
        
        contentView.addSubview(ivProduct)
        
        contentView.addSubview(lblProductName)
        
        [lblPrice, lblDiscountedPrice].forEach {
            priceStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(priceStackView)
        
        contentView.addSubview(lblStock)
    }
    
    private func setupLayout() {
        checkBox.anchor(nil, left: contentView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        checkBox.anchorCenterYToSuperview()
        
        ivProduct.anchor(nil, left: checkBox.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 14, bottomConstant: 0, rightConstant: 0, widthConstant: 74, heightConstant: 74)
        ivProduct.anchorCenterYToSuperview()
        
        lblProductName.anchor(ivProduct.topAnchor, left: ivProduct.rightAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        lblProductName.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        priceStackView.anchor(nil, left: nil, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5 , rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        lblPrice.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        lblDiscountedPrice.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        
        lblStock.anchor(lblProductName.bottomAnchor, left: ivProduct.rightAnchor, bottom: nil, right: priceStackView.leftAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
