//
//  AdminLoginViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 20.05.2022.
//

import UIKit
import ClickmeliveHostCore

public final class AdminLoginViewController: UIViewController, Layouting {
    
    public typealias ViewType = AdminView
    
    public var onUseSmsTapped: (() -> Void)?
    
    private let viewModel: AdminViewModel
    
    public init(viewModel: AdminViewModel) {
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
        layoutableView.tfEmail.text = nil
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    @objc private func loginTapped() {
        let email = layoutableView.tfEmail.text ?? ""
        let password = layoutableView.tfPassword.text ?? ""
        viewModel.login(email: email, password: password)
    }
    
    @objc private func useSmsTapped() {
        onUseSmsTapped?()
    }
    
    private func registerActions() {
        layoutableView.btnLogin.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        layoutableView.btnUseSms.addTarget(self, action: #selector(useSmsTapped), for: .touchUpInside)
    }
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        layoutableView.btnLogin.handleIsEnabled(viewModel.isValid(
            email: textField.text ?? "",
            password: layoutableView.tfPassword.text ?? ""))
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        layoutableView.btnLogin.handleIsEnabled(viewModel.isValid(
            email: layoutableView.tfEmail.text ?? "",
            password: textField.text ?? ""))
    }
    
    private func setupTextField() {
        layoutableView.tfEmail.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        
        layoutableView.tfPassword.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupLocalizedTitles() {
        layoutableView.setLocalizedTitles(with: viewModel)
    }
}
