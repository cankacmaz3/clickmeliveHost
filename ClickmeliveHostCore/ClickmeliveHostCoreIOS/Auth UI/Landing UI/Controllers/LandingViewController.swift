//
//  LandingViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import UIKit
import ClickmeliveHostCore

public final class LandingViewController: UIViewController, Layouting {
    public typealias ViewType = LandingView
    
    public var onLoginTapped: (() -> Void)?
    
    private let landingViewModel: LandingViewModel
    
    public init(landingViewModel: LandingViewModel) {
        self.landingViewModel = landingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizedTitles()
        registerActions()
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    @objc private func loginTapped() {
        onLoginTapped?()
    }
    
    private func registerActions() {
        layoutableView.btnLogin.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private func setupLocalizedTitles() {
        layoutableView.setButtonTitle(landingViewModel.loginButtonTitle)
    }
}
