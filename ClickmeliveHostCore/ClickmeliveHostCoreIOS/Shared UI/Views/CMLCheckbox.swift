//
//  CMLCheckbox.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit

class CMLCheckbox: UIView {
    
    private enum Constants {
        static let checkboxColor = UIColor.rgb(red: 138, green: 57, blue: 255)
        static let borderColor = UIColor.rgb(red: 54, green: 71, blue: 81)
        static let tickImage: String = "img_tick"
    }
    
    private var isChecked = false
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.tickImage,
                                  in: Bundle(for: CMLCheckbox.self),
                                  compatibleWith: nil)
        imageView.tintColor = Constants.checkboxColor
        return imageView
    }()
    
    let boxView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Constants.borderColor.cgColor
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(boxView)
        addSubview(imageView)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boxView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width)
        imageView.constrainHeight(8.42)
        imageView.constrainWidth(12.44)
        imageView.anchorCenterSuperview()
    }
    
    public func setChecked(to value: Bool) {
        self.isChecked = value
        imageView.isHidden = !isChecked
    }
    
    public func toggle() {
        self.isChecked = !isChecked
        imageView.isHidden = !isChecked
    }
}

