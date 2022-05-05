//
//  ChatCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 3.05.2022.
//

import UIKit
import ClickmeliveHostCore

extension ChatCell {
    func configure(with viewModel: ChatViewModel) {
        lblUsername.text = viewModel.username
        lblMessage.text = viewModel.message
    }
}

public final class ChatCell: UITableViewCell {
  
    private let lblUsername: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Fonts.semibold, size: 14)
        label.numberOfLines = 0
        label.UILabelTextShadow()
        return label
    }()
    
    private let lblMessage: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Fonts.semibold, size: 14)
        label.numberOfLines = 0
        label.UILabelTextShadow()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        contentView.addSubview(lblUsername)
        contentView.addSubview(lblMessage)
    }
    
    private func setupLayout() {
        lblUsername.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 12, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        lblMessage.anchor(lblUsername.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 3, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
    }
}

