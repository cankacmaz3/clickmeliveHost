//
//  ProfileView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 30.04.2022.
//

import Foundation
import UIKit
import ClickmeliveHostCore

extension ProfileView {
    func setLocalizedTitles(viewModel: ProfileViewModel) {
        lblLogout.text = viewModel.logoutTitle
    }
}

public final class ProfileView: UIView, Layoutable {
    
    private enum Constants {
        static let seperatorColor: UIColor = UIColor.rgb(red: 221, green: 226, blue: 229)
        static let logoutBgColor: UIColor = UIColor.rgb(red: 245, green: 245, blue: 247)
        
        static let logoutImage: String = "icon_logout"
    }
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.seperatorColor
        return view
    }()
    
    let logoutView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.logoutBgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let ivLogout: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.logoutImage,
                                  in: Bundle(for: ProfileView.self),
                                  compatibleWith: nil)
        return imageView
    }()
    
    private let lblLogout: UILabel = {
        let label = UILabel()
        label.textColor = Colors.primaryText
        label.font = UIFont(name: Fonts.semibold, size: 14)
        return label
    }()
    
    public func setupViews() {
        backgroundColor = .white
        
        addSubview(seperatorView)
        
        [ivLogout, lblLogout].forEach {
            logoutView.addSubview($0)
        }
        
        addSubview(logoutView)
    }
    
    public func setupLayout() {
        seperatorView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        ivLogout.anchor(nil, left: logoutView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 17)
        ivLogout.anchorCenterYToSuperview()
        
        lblLogout.anchor(nil, left: ivLogout.rightAnchor, bottom: nil, right: logoutView.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 25, widthConstant: 0, heightConstant: 0)
        lblLogout.anchorCenterYToSuperview()
        
        logoutView.anchor(seperatorView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 32, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
    }
}
