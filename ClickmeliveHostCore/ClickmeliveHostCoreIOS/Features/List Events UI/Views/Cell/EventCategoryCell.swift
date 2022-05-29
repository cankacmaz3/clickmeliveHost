//
//  CategoryCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 20.04.2022.
//

import UIKit
import ClickmeliveHostCore

extension EventCategoryCell {
    func configure(with viewModel: EventCategoryViewModel) {
        lblName.text = viewModel.localizedIndex
    }
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? Constants.selectedBorderColor.cgColor: Constants.unselectedBorderColor.cgColor
            backgroundColor = isSelected ? Constants.selectedBgColor: Constants.unselectedBgColor
            lblName.textColor = isSelected ? Constants.selectedNameColor: Constants.unselectedNameColor
        }
    }
}

final class EventCategoryCell: UICollectionViewCell {
    
    private enum Constants {
        static let selectedNameColor: UIColor = .white
        static let unselectedNameColor: UIColor = UIColor.rgb(red: 165, green: 171, blue: 175)
        static let selectedBgColor: UIColor = Colors.primary
        static let unselectedBgColor: UIColor = .white
        static let selectedBorderColor: UIColor = Colors.primary
        static let unselectedBorderColor: UIColor = UIColor.rgb(red: 165, green: 171, blue: 175)
    }
    
    private let lblName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textAlignment = .center
        label.textColor = Constants.unselectedNameColor
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        layer.borderWidth = 1.0
        layer.borderColor = Constants.unselectedBorderColor.cgColor
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(lblName)
    }
    
    private func setupLayout() {
        lblName.fillSuperview()
    }
}
