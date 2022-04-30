//
//  EnterPhoneViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import UIKit
import ClickmeliveHostCore

public final class EnterPhoneViewController: UIViewController, Layouting {
    public typealias ViewType = EnterPhoneView
    
    private let viewModel: EnterPhoneViewModel
    
    public init(viewModel: EnterPhoneViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizedTitles()
        setupTextField()
        registerActions()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutableView.tfPhone.text = nil
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    @objc private func sendCodeTapped() {
        let phone = layoutableView.tfPhone.text ?? ""
        viewModel.sendCode(to: phone)
    }
    
    private func registerActions() {
        layoutableView.btnSendCode.addTarget(self, action: #selector(sendCodeTapped), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        textField.text = viewModel.formatPhone(textField.text ?? "")
        layoutableView.btnSendCode.handleIsEnabled(viewModel.isValid(phone: textField.text ?? ""))
    }
    
    private func setupTextField() {
        layoutableView.tfPhone.delegate = self
        layoutableView.tfPhone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupLocalizedTitles() {
        layoutableView.setLocalizedTitles(with: viewModel)
    }
}

// MARK: - TextField delegate methods
extension EnterPhoneViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Make sure all entered characters are numbers
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        
        return true
    }
}
