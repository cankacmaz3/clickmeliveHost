//
//  AddVideoView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 7.06.2022.
//

import Foundation
import UIKit

extension AddVideoView {
    func setContent(fileURL: URL? = nil, image: UIImage?) {
        self.fileURL = fileURL
        self.image = image
        
        ivAddVideo.image = image
        ivCoverPhoto.image = image
    }
}

final class AddVideoView: UIView {
    
    var onAddVideoTapped: (() -> Void)?
    var onPlayVideoTapped: ((URL) -> Void)?
    var onAddCoverPhotoTapped: (() -> Void)?
    
    var fileURL: URL?
    var image: UIImage?
    
    private enum Constants {
        static let addVideoImage: String = "img_select_from_gallery"
    }
    
    private let lblAddVideo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryText
        label.text = "Video Ekle*"
        return label
    }()
    
    private let ivAddVideo: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: Constants.addVideoImage,
                           in: Bundle(for: AddVideoView.self),
                           compatibleWith: nil)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let lblAddVideoMessage: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryPlaceholderText
        label.text = "Video 9:16 formatında, min 10, max 90 saniye ve max 100 mb boyutunda olmalıdır."
        label.numberOfLines = 0
        return label
    }()
    
    private let lblAddCoverPhoto: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryText
        label.text = "Kapak Fotoğrafı Ekle*"
        label.numberOfLines = 0
        return label
    }()
    
    private let ivAddCoverPhotoFromGallery: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: Constants.addVideoImage,
                           in: Bundle(for: AddVideoView.self),
                           compatibleWith: nil)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let ivCoverPhoto: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    @objc private func addVideoTapped() {
        if fileURL == nil {
            onAddVideoTapped?()
        } else {
            onPlayVideoTapped?(fileURL!)
        }
    }
    
    @objc private func addCoverPhotoTapped() {
        onAddCoverPhotoTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let addVideoGesture = UITapGestureRecognizer(target: self, action: #selector(addVideoTapped))
        ivAddVideo.addGestureRecognizer(addVideoGesture)
        
        let coverPhotoGesture = UITapGestureRecognizer(target: self, action: #selector(addCoverPhotoTapped))
        ivAddCoverPhotoFromGallery.addGestureRecognizer(coverPhotoGesture)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(lblAddVideo)
        addSubview(ivAddVideo)
        addSubview(lblAddVideoMessage)
        addSubview(lblAddCoverPhoto)
        addSubview(ivAddCoverPhotoFromGallery)
        addSubview(ivCoverPhoto)
    }
    
    private func setupLayout() {
        lblAddVideo.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        ivAddVideo.anchor(lblAddVideo.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 94, heightConstant: 152)
        lblAddVideoMessage.anchor(ivAddVideo.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        lblAddCoverPhoto.anchor(lblAddVideoMessage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 25, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        ivAddCoverPhotoFromGallery.anchor(lblAddCoverPhoto.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 10, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 94, heightConstant: 152)
        ivCoverPhoto.anchor(lblAddCoverPhoto.bottomAnchor, left: ivAddCoverPhotoFromGallery.rightAnchor, bottom: bottomAnchor, right: nil, topConstant: 10, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 94, heightConstant: 152)
        
    }
}
