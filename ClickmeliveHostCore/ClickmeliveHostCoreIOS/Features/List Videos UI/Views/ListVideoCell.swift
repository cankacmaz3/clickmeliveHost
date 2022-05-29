//
//  ListVideoCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import UIKit
import ClickmeliveHostCore

extension ListVideoCell {
    func configure(with viewModel: EventViewModel, imageLoader: ImageLoader) {
        imageLoader.loadImage(to: ivEvent, with: viewModel.imageURL)
        
        lblTitle.text = viewModel.title
    }
}

final class ListVideoCell: UICollectionViewCell {
    
    private enum Constants {
        static let dimBgImage: String = "img_dim_bg"
        static let playImage: String = "icon_play"
    }
    
    private let ivEvent: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let ivDimBg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: Constants.dimBgImage,
                           in: Bundle(for: ListVideoCell.self),
                           compatibleWith: nil)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private let ivPlay: UIImageView = {
        let iv = UIImageView()
        
        iv.image = UIImage(named: Constants.playImage,
                           in: Bundle(for: ListVideoCell.self),
                           compatibleWith: nil)
        return iv
    }()
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Fonts.semibold, size: 14)
        label.numberOfLines = 2
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
        backgroundColor = .white
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        addSubview(ivEvent)
        addSubview(ivDimBg)
        addSubview(ivPlay)
        addSubview(lblTitle)
    }
    
    private func setupLayout() {
        ivEvent.fillSuperview()
        ivDimBg.anchor(nil, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 66)
        lblTitle.anchor(nil, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 16, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        ivPlay.constrainWidth(20)
        ivPlay.constrainHeight(24)
        ivPlay.anchorCenterSuperview()
    }
}
