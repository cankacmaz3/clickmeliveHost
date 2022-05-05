//
//  BroadcastView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import UIKit
import ClickmeliveHostCore

class EventProductsImageView: UIImageView, BadgeContainer {
    var badgeTimer: Timer?
    var badgeView: UIView?
    var badgeLabel: UILabel?
}

extension BroadcastView {
    
    func setLocalizedTexts(broadcastViewModel: BroadcastViewModel) {
        lblStreamStatus.text = broadcastViewModel.streamStatus
        lblSound.text = broadcastViewModel.soundTitle
        lblRotate.text = broadcastViewModel.rotateTitle
        lblCamera.text = broadcastViewModel.cameraTitle
    }
    
    func updateStreamStatus(broadcastViewModel: BroadcastViewModel) {
        lblStreamStatus.text = broadcastViewModel.streamStatus
        
        ivStream.image = UIImage(named: broadcastViewModel.isRunning ?
                                 Constants.streamStopImage:
                                 Constants.streamStartImage,
                                 in: Bundle(for: BroadcastView.self),
                                 compatibleWith: nil)
        
    }
    
    func toggleEventProductsVisibility(itemCount: Int) {
        collectionView.isHidden.toggle()
        productsToggleView.backgroundColor = collectionView.isHidden == true ?
                                            Constants.showEventsProductColor :
                                            Constants.hideEventsProductColor
    }
    
    func showProductToggleView(count: Int) {
        productsToggleView.isHidden = false
        collectionView.isHidden = false
        ivProductToggle.showBadge(blink: false, text: "\(count)", badgeColor: Constants.badgeColor)
    }
    
    func updateViewerCount(_ count: Int) {
        lblViewer.text = "\(count)"
    }
    
    func handleSoundImage(isMuted: Bool) {
        ivSound.image = UIImage(named: isMuted ? Constants.soundDisabledImage:
                                                 Constants.soundEnabledImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
    }
}

public final class BroadcastView: UIView, Layoutable {
    
    private enum Constants {
        static let bgColor: UIColor = .black.withAlphaComponent(0.8)
        static let soundEnabledImage: String = "img_sound_enabled"
        static let soundDisabledImage: String = "img_sound_disabled"
        static let rotateImage: String = "img_rotate"
        static let cameraImage: String = "img_camera"
        static let streamStartImage: String = "img_stream_start"
        static let streamStopImage: String = "img_stream_stop"
        static let eventProductsImage: String = "icon_event_products"
        static let viewerImage: String = "icon_viewer"
        static let closeImage: String = "img_back"
        
        static let hideEventsProductColor: UIColor = UIColor.rgb(red: 255, green: 0, blue: 27).withAlphaComponent(0.3)
        static let showEventsProductColor: UIColor = UIColor.rgb(red: 16, green: 139, blue: 0).withAlphaComponent(0.3)
        static let badgeColor: UIColor = Colors.primary
        static let streamStatusBgColor: UIColor = UIColor.rgb(red: 73, green: 80, blue: 87)
    }
    
    // MARK: - Back
    let closeView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let ivClose: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: Constants.closeImage, in: Bundle(for: BroadcastView.self), compatibleWith: nil)
        return iv
    }()
    
    // MARK: - Viewers
    let viewersView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.15)
        view.layer.cornerRadius = 11.5
        view.isHidden = true
        return view
    }()
    
    private let ivViewer: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.viewerImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
        return imageView
    }()
    
    private let lblViewer: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = .white
        label.UILabelTextShadow()
        return label
    }()
    
    // MARK: - Products Toggle
    let productsToggleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 28
        view.backgroundColor = Constants.hideEventsProductColor
        view.isHidden = true
        return view
    }()
    
    private let ivProductToggle: EventProductsImageView = {
        let imageView = EventProductsImageView()
        imageView.image = UIImage(named: Constants.eventProductsImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
        return imageView
    }()
    
    // MARK: - Products Collection View
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.isHidden = true
        return cv
    }()
    
    // MARK: - Chat TableView
    let chatTableView: UITableView = {
        let tv = UITableView(frame: .zero)
        
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .clear
        tv.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        return tv
    }()

    // MARK: - Camera Preview
    let previewView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // MARK: - Control Buttons
    private let controlButtonsView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.bgColor
        return view
    }()
    
    private let controlButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let soundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    let soundImageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let ivSound: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.soundEnabledImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let lblSound: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.medium, size: 12)
        label.textColor = .white
        return label
    }()
    
    private let cameraStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    let cameraImageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let ivCamera: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.cameraImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let lblCamera: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.medium, size: 12)
        label.textColor = .white
        return label
    }()
    
    private let rotateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    let rotateImageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let ivRotate: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.rotateImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let lblRotate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.medium, size: 12)
        label.textColor = .white
        return label
    }()
    
    private let streamStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    let streamImageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let ivStream: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.streamStartImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let lblStreamStatus: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.medium, size: 12)
        label.textColor = .white
        
        return label
    }()
    
    let lblTimer: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.medium, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    public func setupViews() {
        backgroundColor = .black
        
        addSubview(previewView)
        addSubview(chatTableView)
        
        addSubview(controlButtonsView)
        
        soundImageContainer.addSubview(ivSound)
        [soundImageContainer, lblSound].forEach {
            soundStackView.addArrangedSubview($0)
        }
        
        cameraImageContainer.addSubview(ivCamera)
        [cameraImageContainer, lblCamera].forEach {
            cameraStackView.addArrangedSubview($0)
        }
        
        rotateImageContainer.addSubview(ivRotate)
        [rotateImageContainer, lblRotate].forEach {
            rotateStackView.addArrangedSubview($0)
        }
        
        ivStream.addSubview(lblTimer)
        streamImageContainer.addSubview(ivStream)
        [streamImageContainer, lblStreamStatus].forEach {
            streamStackView.addArrangedSubview($0)
        }
        
        [soundStackView, cameraStackView, rotateStackView, streamStackView].forEach {
            controlButtonsStackView.addArrangedSubview($0)
        }
        
        controlButtonsView.addSubview(controlButtonsStackView)
        
        [ivViewer, lblViewer].forEach {
            viewersView.addSubview($0)
        }
        
        addSubview(viewersView)
        
        productsToggleView.addSubview(ivProductToggle)
        addSubview(productsToggleView)
        addSubview(collectionView)
        
        closeView.addSubview(ivClose)
        addSubview(closeView)
    }
    
    public func setupLayout() {
        
        closeView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 56, heightConstant: 56)
        
        ivClose.anchor(closeView.topAnchor, left: closeView.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 29, bottomConstant: 0, rightConstant: 0, widthConstant: 10, heightConstant: 19)
        
        viewersView.anchor(safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 23)
        viewersView.anchorCenterXToSuperview()
        
        ivViewer.anchor(nil, left: viewersView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 13, heightConstant: 10)
        ivViewer.anchorCenterYToSuperview()
        
        lblViewer.anchor(viewersView.topAnchor, left: ivViewer.rightAnchor, bottom: viewersView.bottomAnchor, right: viewersView.rightAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        productsToggleView.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 56, heightConstant: 56)
        
        addConstraint(NSLayoutConstraint(item: productsToggleView, attribute: .centerY, relatedBy: .equal, toItem: collectionView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        ivProductToggle.anchorCenterSuperview()
        ivProductToggle.constrainWidth(27)
        ivProductToggle.constrainHeight(27)
        
        collectionView.anchor(viewersView.bottomAnchor, left: productsToggleView.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 138)
        
        previewView.anchor(topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 2, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        chatTableView.anchor(collectionView.bottomAnchor, left: leftAnchor, bottom: controlButtonsView.topAnchor, right: rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        controlButtonsView.anchor(nil, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 130)
        
        ivSound.anchorCenterXToSuperview()
        ivSound.constrainHeight(56)
        ivSound.constrainWidth(56)
        
        ivCamera.anchorCenterXToSuperview()
        ivCamera.constrainHeight(56)
        ivCamera.constrainWidth(56)
        
        ivRotate.anchorCenterXToSuperview()
        ivRotate.constrainHeight(56)
        ivRotate.constrainWidth(56)
        
        ivStream.anchorCenterXToSuperview()
        ivStream.constrainHeight(56)
        ivStream.constrainWidth(56)
        
        lblTimer.fillSuperview()
        
        controlButtonsStackView.anchor(controlButtonsView.topAnchor, left: controlButtonsView.leftAnchor, bottom: nil, right: controlButtonsView.rightAnchor, topConstant: 27, leftConstant: 27, bottomConstant: 0, rightConstant: 27, widthConstant: 0, heightConstant: 79)
        
    }
}
