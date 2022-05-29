//
//  AlertViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import UIKit
import ClickmeliveHostCore

public final class AlertViewController: UIViewController, Layouting {
    public typealias ViewType = AlertView
    
    public var onActionTapped: (() -> Void)?
    public var onCloseTapped: (() -> Void)?
    
    private let viewModel: AlertViewModel
    
    public init(viewModel: AlertViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        layoutableView.setTitles(messageTitle: viewModel.message, buttonTitle: viewModel.actionButtonTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        registerActions()
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    @objc private func closeTapped() {
        onCloseTapped?()
    }
    
    @objc private func actionTapped() {
        onActionTapped?()
        onCloseTapped?()
    }
    
    private func registerActions() {
        layoutableView.btnAction.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
        layoutableView.closeView.addGestureRecognizer(closeGesture)
    }
}
