//
//  BroadcastView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import UIKit

extension BroadcastView {
    func handleSoundImage(isMuted: Bool) {
        ivSound.image = UIImage(named: isMuted ? Constants.soundOffImage:
                                                 Constants.soundOnImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
    }
}

public final class BroadcastView: UIView, Layoutable {
    
    private enum Constants {
        static let controlButtonsBg: UIColor = .black.withAlphaComponent(0.7)
        static let soundOnImage: String = "img_sound_on"
        static let soundOffImage: String = "img_sound_off"
        static let rotateCameraImage: String = "img_rotate_camera"
        static let streamStatusBgColor: UIColor = UIColor.rgb(red: 73, green: 80, blue: 87)
        static let streamStatusStartColor: UIColor = UIColor.rgb(red: 42, green: 185, blue: 48)
        static let streamStatusStopColor: UIColor = UIColor.rgb(red: 255, green: 0, blue: 27)
    }
    
    let previewView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let controlButtonsView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.controlButtonsBg
        return view
    }()
    
    let ivSound: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.soundOnImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let ivRotateCamera: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.rotateCameraImage,
                                  in: Bundle(for: BroadcastView.self),
                                  compatibleWith: nil)
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.distribution = .fill
        return stackView
    }()
    
    private let streamStatusContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let streamStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.streamStatusBgColor
        view.layer.borderColor = Constants.streamStatusStartColor.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 23
        return view
    }()
    
    let lblStreamStatus: UILabel = {
        let label = UILabel()
        label.text = "Canlı yayın başlat"
        label.font = UIFont(name: Fonts.medium, size: 12)
        
        return label
    }()
    
    public func setupViews() {
        backgroundColor = .black
        
        addSubview(previewView)
        
        addSubview(controlButtonsView)
        
        streamStatusContainer.addSubview(streamStatusView)
        
        [streamStatusContainer, lblStreamStatus].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [ivSound, stackView, ivRotateCamera].forEach {
            controlButtonsView.addSubview($0)
        }
    }
    
    public func setupLayout() {
        previewView.fillSuperview()
        
        controlButtonsView.anchor(nil, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 101)
        
        streamStatusView.anchorCenterSuperview()
        streamStatusView.constrainWidth(46)
        streamStatusView.constrainHeight(46)
        
        ivSound.anchor(nil, left: controlButtonsView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        ivSound.anchorCenterYToSuperview()
        
        ivRotateCamera.anchor(nil, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 40, heightConstant: 40)
        ivRotateCamera.anchorCenterYToSuperview()
        
        streamStatusContainer.constrainHeight(48)
        
        stackView.anchorCenterSuperview()
    }
}
