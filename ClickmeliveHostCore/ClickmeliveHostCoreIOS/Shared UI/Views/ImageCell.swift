//
//  ImageCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 7.06.2022.
//

import UIKit
import SDWebImage

extension ImageCell {
    func configure(image: String?) {
        setImage(with: image)
    }
    
    private func setImage(with image: String?) {
        guard let image = image else { return }
        imageView.sd_imageTransition = .fade
        imageView.sd_setImage(with: URL(string: image), completed: nil)
    }
}

final class ImageCell: UICollectionViewCell {
    
    var onDeleteTapped: (() -> Void)?
    
    private enum Constants {
        static let borderColor: UIColor = UIColor.rgb(red: 221, green: 226, blue: 229)
        static let closeImage: String = "icon_close_white"
    }
   
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = Constants.borderColor.cgColor
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let closeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.closeImage,
                                  in: Bundle(for: ListProductsHeaderCell.self),
                                  compatibleWith: nil)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    @objc private func deleteTapped() {
        onDeleteTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(deleteTapped))
        closeImageView.addGestureRecognizer(gesture)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
    }
    
    private func setupLayout() {
        imageView.addSubview(closeImageView)
        closeImageView.anchor(imageView.topAnchor, left: nil, bottom: nil, right: imageView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 13, heightConstant: 13)
        
        imageView.fillSuperview()
    }
}
