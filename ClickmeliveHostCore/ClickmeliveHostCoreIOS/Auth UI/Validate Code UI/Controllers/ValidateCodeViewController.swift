//
//  ValidateCodeViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import UIKit
import ClickmeliveHostCore

public final class ValidateCodeViewController: UIViewController, Layouting {
    
    private enum Constants {
        static let codeMaxLength: Int = 6
    }
    
    public typealias ViewType = ValidateCodeView
    
    private let viewModel: ValidateCodeViewModel
    
    public init(viewModel: ValidateCodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizedTexts()
        setupTextField()
        registerActions()
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    @objc private func validateTapped() {
        let code = layoutableView.tfValidate.text ?? ""
        viewModel.validate(code: code)
    }
    
    private func registerActions() {
        layoutableView.btnValidate.addTarget(self, action: #selector(validateTapped), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let code = textField.text else { return }
        layoutableView.btnValidate.handleIsEnabled(viewModel.isValid(code: code))
        textField.text = code
        
        if code.count == Constants.codeMaxLength {
            validateTapped()
        }
    }
    
    private func setupTextField() {
        layoutableView.tfValidate.delegate = self
        layoutableView.tfValidate.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupLocalizedTexts() {
        layoutableView.setLocalizedTexts(with: viewModel)
    }
    
}


// MARK: - TextField delegate methods
extension ValidateCodeViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /// Make sure all entered characters are numbers
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        
        // Handle max length
        let maxLength = Constants.codeMaxLength
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
}
