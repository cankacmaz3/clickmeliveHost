//
//  BroadcastViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import UIKit
import AmazonIVSBroadcast

public final class BroadcastViewController: UIViewController, Layouting {
    public typealias ViewType = BroadcastView
    
    private let broadcastEventProductsController: BroadcastEventProductsController
    
    public init(broadcastEventProductsController: BroadcastEventProductsController) {
        self.broadcastEventProductsController = broadcastEventProductsController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerActions()
        observeProductEventLoad()
        
        broadcastEventProductsController.loadEventProducts(eventId: 1338)
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    @objc private func toggleEventProducts() {
        layoutableView.toggleEventProductsVisibility(itemCount: broadcastEventProductsController.numberOfProducts())
    }
    
    private func registerActions() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleEventProducts))
        layoutableView.productToggleView.addGestureRecognizer(gesture)
    }
    
    private func observeProductEventLoad() {
        broadcastEventProductsController.onEventProductsLoaded = { [weak self] count in
            self?.layoutableView.showProductToggleView(count: count)
        }
    }
    
    public func setupCollectionView() {
        broadcastEventProductsController.bind(collectionView: layoutableView.collectionView)
    }
}
