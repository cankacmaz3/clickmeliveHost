//
//  CategoryCell.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 24.05.2022.
//

import UIKit
import ClickmeliveHostCore

extension CategoryCell {
    func configure(with viewModel: CategoryViewModel) {
        lblName.text = viewModel.localizedTitle
    }
    
    override var isSelected: Bool {
        didSet {
            selectedLine.backgroundColor = isSelected ? Constants.bottomLineColor : .clear
            lblName.textColor = isSelected ? Constants.selectedNameColor : Constants.unselectedNameColor
        }
    }
}

final class CategoryCell: UICollectionViewCell {
    
    private enum Constants {
        static let selectedNameColor: UIColor = Colors.primary
        static let unselectedNameColor: UIColor = UIColor.rgb(red: 165, green: 171, blue: 175)
        static let bottomLineColor: UIColor = Colors.primary
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let topSpaceView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let lblName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.medium, size: 14)
        label.textAlignment = .center
        label.textColor = Constants.unselectedNameColor
        
        return label
    }()
    
    private let selectedLine: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [topSpaceView, lblName, selectedLine].forEach {
            stackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(stackView)
    }
    
    private func setupLayout() {
        stackView.fillSuperview()
        stackView.constrainHeight(40)
        topSpaceView.constrainHeight(7)
        selectedLine.constrainHeight(3)
    }
}
