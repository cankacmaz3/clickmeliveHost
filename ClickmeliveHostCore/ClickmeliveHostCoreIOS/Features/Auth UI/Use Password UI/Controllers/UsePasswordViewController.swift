//
//  UsePasswordViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.05.2022.
//

import UIKit
import ClickmeliveHostCore

public final class UsePasswordViewController: UIViewController, Layouting {
    
    private enum Constants {
        static let codeMaxLength: Int = 6
    }
    
    public typealias ViewType = UsePasswordView
    
    public var onUseSmsTapped: (() -> Void)?
    
    private let viewModel: UsePasswordViewModel
    
    public init(viewModel: UsePasswordViewModel) {
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
    
    @objc private func loginTapped() {
        let phone = layoutableView.tfPhone.text ?? ""
        let password = layoutableView.tfPassword.text ?? ""
        viewModel.login(phone: phone, password: password)
    }
    
    @objc private func useSmsTapped() {
        onUseSmsTapped?()
    }
    
    private func registerActions() {
        layoutableView.btnLogin.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        layoutableView.btnUseSms.addTarget(self, action: #selector(useSmsTapped), for: .touchUpInside)
    }
    
    @objc private func phoneTextFieldDidChange(_ textField: UITextField) {
        textField.text = viewModel.formatPhone(textField.text ?? "")
        layoutableView.btnLogin.handleIsEnabled(viewModel.isValid(
            phone: textField.text ?? "",
            password: layoutableView.tfPassword.text ?? ""))
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        layoutableView.btnLogin.handleIsEnabled(viewModel.isValid(
            phone: layoutableView.tfPhone.text ?? "",
            password: textField.text ?? ""))
    }
    
    private func setupTextField() {
        layoutableView.tfPhone.delegate = self
        layoutableView.tfPhone.addTarget(self, action: #selector(phoneTextFieldDidChange(_:)), for: .editingChanged)
        
        layoutableView.tfPassword.delegate = self
        layoutableView.tfPassword.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupLocalizedTitles() {
        layoutableView.setLocalizedTitles(with: viewModel)
    }
}

// MARK: - TextField delegate methods
extension UsePasswordViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Make sure all entered characters are numbers
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        
        if textField == layoutableView.tfPassword {
            // Handle max length
            let maxLength = Constants.codeMaxLength
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            return newString.length <= maxLength
        }
        
        return true
    }
}
