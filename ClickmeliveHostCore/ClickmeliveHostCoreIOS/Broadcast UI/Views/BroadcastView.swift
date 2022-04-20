//
//  BroadcastView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import UIKit

public final class BroadcastView: UIView, Layoutable {
    
    private enum Constants {
        static let controlButtonsBg: UIColor = .black.withAlphaComponent(0.7)
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
    
    private let ivSound: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let ivRotateCamera: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
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
        view.backgroundColor = .green
        return view
    }()
    
    let lblStreamStatus: UILabel = {
        let label = UILabel()
        label.text = "Canlı yayın başlat"
        label.font = UIFont(name: Fonts.medium, size: 12)
        
        return label
    }()
    
    public func setupViews() {
        backgroundColor = .white
        addSubview(previewView)
        
        addSubview(controlButtonsView)
        
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
        
        ivSound.anchor(nil, left: controlButtonsView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        ivSound.anchorCenterYToSuperview()
        
        ivRotateCamera.anchor(nil, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 40, heightConstant: 40)
        ivRotateCamera.anchorCenterYToSuperview()
        
        streamStatusContainer.constrainHeight(48)
        
        stackView.anchorCenterSuperview()
    }
}
