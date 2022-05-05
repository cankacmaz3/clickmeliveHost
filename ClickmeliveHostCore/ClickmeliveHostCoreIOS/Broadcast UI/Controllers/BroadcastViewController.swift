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
    
    public var onClose: (() -> Void)?
    
    internal let event: Event
    internal let broadcastViewModel: BroadcastViewModel
    private let viewerViewModel: ViewerViewModel
    private let broadcastEventProductsController: BroadcastEventProductsController
    private let broadcastChatController: BroadcastChatController
    
    public init(event: Event,
                broadcastViewModel: BroadcastViewModel,
                viewerViewModel: ViewerViewModel,
                broadcastEventProductsController: BroadcastEventProductsController,
                broadcastChatController: BroadcastChatController) {
        self.event = event
        self.broadcastViewModel = broadcastViewModel
        self.viewerViewModel = viewerViewModel
        self.broadcastEventProductsController = broadcastEventProductsController
        self.broadcastChatController = broadcastChatController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit BroadcastViewController")
    }
    
    // MARK: - Broadcast related methods
    public var attachedCamera: IVSDevice? {
        didSet {
            if let preview = try? (attachedCamera as? IVSImageDevice)?.previewView(with: .fill) {
                attachCameraPreview(container: layoutableView.previewView, preview: preview)
            } else {
                layoutableView.previewView.subviews.forEach { $0.removeFromSuperview() }
            }
        }
    }
    
    public var attachedMicrophone: IVSDevice? {
        didSet {
            // When a new microphone is attached it has a default gain of 1. This reapplies the mute setting
            // immediately after the new microphone is attached.
            applyMute()
        }
    }
    
    // This broadcast session is the main interaction point with the SDK
    public var broadcastSession: IVSBroadcastSession?
}

// MARK: - Lifecycle related methods
extension BroadcastViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupChatTableView()
        
        setupLocalizedTexts()
        registerActions()
        
        observeViewerCount()
        observeProductEventLoad()
        setupBroadcastObservers()
        
        viewerViewModel.listenViewerUpdates(eventId: event.id)
        broadcastEventProductsController.loadEventProducts(eventId: event.id)
        
        broadcasterViewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        viewerViewModel.removeViewerListener()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        broadcasterViewDidAppear()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        broadcasterViewDidDisappear()
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    private func setupLocalizedTexts() {
        layoutableView.setLocalizedTexts(broadcastViewModel: broadcastViewModel)
    }
    
    public func setupCollectionView() {
        broadcastEventProductsController.bind(collectionView: layoutableView.collectionView)
    }
    
    public func setupChatTableView() {
        broadcastChatController.bind(tableView: layoutableView.chatTableView)
    }
    
    private func registerActions() {
        let productsToggleGesture = UITapGestureRecognizer(target: self, action: #selector(toggleEventProducts))
        layoutableView.productsToggleView.addGestureRecognizer(productsToggleGesture)
        
        let soundGesture = UITapGestureRecognizer(target: self, action: #selector(muteTapped))
        layoutableView.soundImageContainer.addGestureRecognizer(soundGesture)
        
        let rotateGesture = UITapGestureRecognizer(target: self, action: #selector(cameraTapped))
        layoutableView.rotateImageContainer.addGestureRecognizer(rotateGesture)
        
        let streamGesture = UITapGestureRecognizer(target: self, action: #selector(streamTapped))
        layoutableView.streamImageContainer.addGestureRecognizer(streamGesture)
        
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
        layoutableView.closeView.addGestureRecognizer(closeGesture)
    }
}

// MARK: - Event Products related methods
extension BroadcastViewController {
    @objc private func toggleEventProducts() {
        layoutableView.toggleEventProductsVisibility(itemCount: broadcastEventProductsController.numberOfProducts())
    }
    
    private func observeProductEventLoad() {
        broadcastEventProductsController.onEventProductsLoaded = { [weak self] count in
            self?.layoutableView.showProductToggleView(count: count)
        }
    }
}

// MARK: - Viewer count related methods
extension BroadcastViewController {
    private func observeViewerCount() {
        viewerViewModel.onMessageReceived = { [weak self] viewerCount in
            DispatchQueue.main.async {
                self?.layoutableView.updateViewerCount(viewerCount)
            }
        }
    }
}
