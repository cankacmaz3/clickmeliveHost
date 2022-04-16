//
//  EventCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import UIKit
import ClickmeliveHostCore

extension EventCell {
    func configure(with viewModel: EventViewModel) {
        lblTitle.text = viewModel.title
    }
}

public final class EventCell: UITableViewCell {
    
    private enum Constants {
        static let borderColor: UIColor = UIColor.rgb(red: 221, green: 226, blue: 229)
        static let titleTextColor: UIColor = Colors.primaryText
    }
    
    private let eventView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = Constants.borderColor.cgColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let ivEvent: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        
        return iv
    }()
    
    private let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.borderColor
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        return stackView
    }()
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "Yengeç Burcu Makyajı Nasıl Yapılır?"
        label.textColor = Constants.titleTextColor
        label.font = UIFont(name: Fonts.semibold, size: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private let lblDate: UILabel = {
        let label = UILabel()
        label.text = "Haz, 29 2022 18:30"
        label.textColor = Constants.titleTextColor
        label.font = UIFont(name: Fonts.medium, size: 14)
        return label
    }()
    
    private let lblRemainingTime: UILabel = {
        let label = UILabel()
        label.text = "Kalan Süre: 3 sa 43 dk."
        label.textColor = Constants.titleTextColor
        label.font = UIFont(name: Fonts.regular, size: 14)
        return label
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
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
        
        contentView.addSubview(eventView)
        
        [ivEvent, seperator].forEach {
            eventView.addSubview($0)
        }
        
        [lblTitle, lblDate, lblRemainingTime, statusView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(stackView)
    }
    
    private func setupLayout() {
        eventView.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        ivEvent.anchor(eventView.topAnchor, left: eventView.leftAnchor, bottom: eventView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 108, heightConstant: 0)
        
        seperator.anchor(eventView.topAnchor, left: nil, bottom: eventView.bottomAnchor, right: ivEvent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 1, heightConstant: 0)
        
        statusView.constrainHeight(30)
        
        stackView.anchor(eventView.topAnchor, left: ivEvent.rightAnchor, bottom: eventView.bottomAnchor, right: eventView.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 12, rightConstant: 12, widthConstant: 0, heightConstant: 0)
    }
}
