//
//  StartingDateView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import UIKit
import IQKeyboardManagerSwift

extension StartingDateView {
    @objc private func dateSelected() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        tfStartingDate.text = dateFormatter.string(from: datePickerView.date)
    }
    
    func getSelectedDate() -> Date {
        return datePickerView.date
    }
}

final class StartingDateView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let lblStartingDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryText
        label.text = "Tarih ve Saat"
        return label
    }()
    
    let tfStartingDate: UITextField = {
        let tf = CMLTextField(padding: 15,
                              font: UIFont(name: Fonts.regular, size: 14)!,
                              cornerRadius: 4)
        tf.keyboardToolbar.doneBarButton.tintColor = Colors.primary
        tf.keyboardToolbar.doneBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.primary,
                                                                        NSAttributedString.Key.font: UIFont(name: Fonts.medium, size: 14)!], for: UIControl.State.normal)
        
        tf.attributedPlaceholder = NSAttributedString(
            string: "Tarih ve saat seçiniz.",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.primaryPlaceholderText,
                         NSAttributedString.Key.font: UIFont(name: Fonts.regular, size: 14)!])
        return tf
    }()
    
    var datePickerView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.minuteInterval = 15
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tfStartingDate.addRightButtonOnKeyboardWithText("Seç", target: self, action: #selector(dateSelected))
        
        tfStartingDate.inputView = datePickerView
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [lblStartingDate, tfStartingDate].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(stackView)
    }
    
    private func setupLayout() {
        stackView.fillSuperview()
        tfStartingDate.constrainHeight(50)
    }
}
