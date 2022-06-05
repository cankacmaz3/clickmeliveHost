//
//  CreateContentCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//
import UIKit

extension CreateContentCell {
    func setTitle(_ title: String) {
        lblTitle.text = title
    }
}

public final class CreateContentCell: UITableViewCell {
    
    private enum Constants {
        static let arrowImage: String = "icon_right_arrow"
    }
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = Colors.primaryText
        label.font = UIFont(name: Fonts.medium, size: 14)
        return label
    }()
    
    private let ivArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: Constants.arrowImage,
                           in: Bundle(for: CreateContentCell.self),
                           compatibleWith: nil)
        return iv
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
        backgroundColor = .white
    
        contentView.addSubview(lblTitle)
        contentView.addSubview(ivArrow)
    }
    
    private func setupLayout() {
        ivArrow.anchor(nil, left: nil, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 24, widthConstant: 7, heightConstant: 14)
        ivArrow.anchorCenterYToSuperview()
        
        lblTitle.anchor(nil, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 0)
        lblTitle.anchorCenterYToSuperview()
    }
}

