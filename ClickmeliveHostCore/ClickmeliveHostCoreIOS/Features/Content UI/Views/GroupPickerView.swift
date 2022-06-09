//
//  LivestreamPickerView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import UIKit
import IQKeyboardManagerSwift
import ClickmeliveHostCore

extension GroupPickerView {
    func populate(with groups: [EventGroup]) {
        self.groups = groups
    }
    
    @objc private func groupSelected() {
        tfGroups.resignFirstResponder()
        
        guard !groups.isEmpty else { return }
        
        let selectedGroup = groups[pickerView.selectedRow(inComponent: 0)]
        tfGroups.text = selectedGroup.name
    }
    
    func getSelectedGroupId() -> Int? {
        guard !groups.isEmpty else { return nil }
        let selectedGroup = groups[pickerView.selectedRow(inComponent: 0)]
        return selectedGroup.id
    }
}

final class GroupPickerView: UIView {
    
    private var groups: [EventGroup] = []
    
    private let groupsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let lblGroups: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semibold, size: 12)
        label.textColor = Colors.primaryText
        return label
    }()
    
    let tfGroups: UITextField = {
        let tf = CMLTextField(padding: 15,
                              font: UIFont(name: Fonts.regular, size: 14)!,
                              cornerRadius: 4)
        tf.keyboardToolbar.doneBarButton.tintColor = Colors.primary
        tf.keyboardToolbar.doneBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.primary,
                                                                        NSAttributedString.Key.font: UIFont(name: Fonts.medium, size: 14)!], for: UIControl.State.normal)
        return tf
    }()
    
    let pickerView: UIPickerView = {
        let view = UIPickerView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tfGroups.addRightButtonOnKeyboardWithText("Seç", target: self, action: #selector(groupSelected))
        
        tfGroups.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [lblGroups, tfGroups].forEach {
            groupsStackView.addArrangedSubview($0)
        }
        
        addSubview(groupsStackView)
    }
    
    private func setupLayout() {
        groupsStackView.fillSuperview()
        tfGroups.constrainHeight(50)
    }
}

extension GroupPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groups.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groups[row].name
    }
}
