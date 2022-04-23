//
//  EventCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import UIKit
import ClickmeliveHostCore
import SDWebImage

extension EventCell {
    func configure(with viewModel: EventViewModel) {
        setImage(with: viewModel.image)
        lblTitle.text = viewModel.title
        lblDate.text = viewModel.startingDate
        ivLive.isHidden = viewModel.isStartBroadcastHidden
        statusStackView.isHidden = !viewModel.isStartBroadcastHidden
        startBroadcastView.isHidden = viewModel.isStartBroadcastHidden
        
        lblStartBroadcast.text = viewModel.localizedStatus
        lblStatus.text = viewModel.localizedStatus
        
        let statusColor = setStatusColors(viewModel: viewModel)
        lblStatus.textColor = statusColor
        statusColorView.backgroundColor = statusColor.withAlphaComponent(0.5)
        statusColorView.layer.borderColor = statusColor.cgColor
        
        
    }
    
    private func setImage(with image: String?) {
        guard let image = image else { return }
        ivEvent.sd_imageTransition = .fade
        ivEvent.sd_setImage(with: URL(string: image), completed: nil)
    }
    
    private func setStatusColors(viewModel: EventViewModel) -> UIColor {
        switch viewModel.status {
        case .UPCOMING:
            if viewModel.isStartBroadcastHidden == false {
                return UIColor.rgb(red: 255, green: 0, blue: 27)
            } else if viewModel.isStatusSoon == true {
                return UIColor.rgb(red: 255, green: 0, blue: 27)
            } else {
                return UIColor.rgb(red: 16, green: 139, blue: 27)
            }
        case .ENDED:
            return UIColor.rgb(red: 165, green: 171, blue: 175)
        case .CANCELLED:
            return UIColor.rgb(red: 179, green: 103, blue: 155)
        default:
            return .white
        }
    }
}

extension EventCell {
    @objc func startBroadcastTapped() {
        onStartBroadcastTapped?()
    }
}

public final class EventCell: UITableViewCell {
    
    var onStartBroadcastTapped: (() -> Void)?
    
    private enum Constants {
        static let borderColor: UIColor = UIColor.rgb(red: 221, green: 226, blue: 229)
        static let titleTextColor: UIColor = Colors.primaryText
        static let liveImage: String = "img_live"
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
    
    private let ivLive: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: Constants.liveImage, in: Bundle(for: EventCell.self), compatibleWith: nil)
        return iv
    }()
    
    private let ivEvent: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.borderColor
        return view
    }()
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = Constants.titleTextColor
        label.font = UIFont(name: Fonts.semibold, size: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private let lblDate: UILabel = {
        let label = UILabel()
        label.textColor = Constants.titleTextColor
        label.font = UIFont(name: Fonts.medium, size: 14)
        return label
    }()
    
    private let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let statusColorView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let lblStatus: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: Fonts.semibold, size: 12)
        return label
    }()
    
    let startBroadcastView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 255, green: 0, blue: 27)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let lblStartBroadcast: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Fonts.semibold, size: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(startBroadcastTapped))
        startBroadcastView.addGestureRecognizer(gesture)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
    
        [ivEvent, ivLive ,seperator, lblTitle, lblDate].forEach {
            eventView.addSubview($0)
        }
        
        contentView.addSubview(eventView)
        
        [statusColorView, lblStatus].forEach {
            statusStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(statusStackView)
        
        startBroadcastView.addSubview(lblStartBroadcast)
        contentView.addSubview(startBroadcastView)
    }
    
    private func setupLayout() {
        eventView.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        ivEvent.anchor(eventView.topAnchor, left: eventView.leftAnchor, bottom: eventView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 108, heightConstant: 0)
        
        ivLive.anchor(eventView.topAnchor, left: nil, bottom: nil, right: eventView.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 25, heightConstant: 25)
        
        seperator.anchor(eventView.topAnchor, left: nil, bottom: eventView.bottomAnchor, right: ivEvent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 1, heightConstant: 0)
        
        lblTitle.anchor(eventView.topAnchor, left: seperator.rightAnchor, bottom: nil, right: eventView.rightAnchor, topConstant: 16, leftConstant: 11, bottomConstant: 0, rightConstant: 52, widthConstant: 0, heightConstant: 0)
        
        lblDate.anchor(lblTitle.bottomAnchor, left: seperator.rightAnchor, bottom: nil, right: eventView.rightAnchor, topConstant: 14, leftConstant: 11, bottomConstant: 0, rightConstant: 11, widthConstant: 0, heightConstant: 0)
        
        statusColorView.constrainHeight(6)
        statusColorView.constrainWidth(6)
        
        statusStackView.anchor(nil, left: seperator.rightAnchor, bottom: eventView.bottomAnchor, right: eventView.rightAnchor, topConstant: 0, leftConstant: 11, bottomConstant: 20, rightConstant: 11, widthConstant: 0, heightConstant: 0)
        
        startBroadcastView.anchor(nil, left: seperator.rightAnchor, bottom: eventView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 11, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        lblStartBroadcast.anchor(startBroadcastView.topAnchor, left: startBroadcastView.leftAnchor, bottom: startBroadcastView.bottomAnchor, right: startBroadcastView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
    }
}
