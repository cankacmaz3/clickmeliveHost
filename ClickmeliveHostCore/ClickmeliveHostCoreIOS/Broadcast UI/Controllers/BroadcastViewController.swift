//
//  BroadcastViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import UIKit
import AmazonIVSBroadcast
import ClickmeliveHostCore

public final class BroadcastViewController: UIViewController, Layouting {
    public typealias ViewType = BroadcastView
    
    private let viewerViewModel: ViewerViewModel
    private let broadcastEventProductsController: BroadcastEventProductsController
    
    public init(viewerViewModel: ViewerViewModel,
                broadcastEventProductsController: BroadcastEventProductsController) {
        self.viewerViewModel = viewerViewModel
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
        
        observeViewerCount()
        observeProductEventLoad()
        
        viewerViewModel.listenViewerUpdates(eventId: 1338)
        broadcastEventProductsController.loadEventProducts(eventId: 1338)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    private func observeViewerCount() {
        viewerViewModel.onMessageReceived = { [weak self] viewerCount in
            self?.layoutableView.updateViewerCount(viewerCount)
        }
    }
    
    public func setupCollectionView() {
        broadcastEventProductsController.bind(collectionView: layoutableView.collectionView)
    }
}
