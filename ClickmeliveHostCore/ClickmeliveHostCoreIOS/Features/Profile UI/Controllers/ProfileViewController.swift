//
//  ProfileViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 30.04.2022.
//

import Foundation
import UIKit
import ClickmeliveHostCore

public final class ProfileViewController: UIViewController, Layouting {
    public typealias ViewType = ProfileView
    
    public var onLogoutTapped: (() -> Void)?
    
    private let viewModel: ProfileViewModel
    
    public init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        layoutableView.setLocalizedTitles(viewModel: viewModel)
        registerActions()
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    @objc private func logoutTapped() {
        onLogoutTapped?()
    }
    
    private func registerActions() {
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutTapped))
        layoutableView.logoutView.addGestureRecognizer(logoutGesture)
    }
}
