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
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    private func setupLocalizedTitles() {
        layoutableView.setLocalizedTitles(with: viewModel)
    }
}
