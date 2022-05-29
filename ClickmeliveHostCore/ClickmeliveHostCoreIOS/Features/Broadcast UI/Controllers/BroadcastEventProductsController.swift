//
//  BroadcastEventProductsController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import UIKit
import ClickmeliveHostCore

public final class BroadcastEventProductsController: NSObject {
    
    var onEventProductsLoaded: ((_ count: Int) -> Void)?
    
    private enum Constants {
        static let cellId: String = "\(ProductCell.self)"
        static let cellWidth: CGFloat = 73
    }
    
    var collectionView: UICollectionView?
    
    private var loadingControllers = [IndexPath: ProductCellController]()
        
    private var collectionModel = [ProductCellController]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    private let viewModel: EventProductViewModel
    
    public init(viewModel: EventProductViewModel) {
        self.viewModel = viewModel
    }
    
    public func display(_ cellControllers: [ProductCellController]) {
        loadingControllers = [:]
        collectionModel = cellControllers
        onEventProductsLoaded?(collectionModel.count)
    }
    
    func loadEventProducts(eventId: Int) {
        viewModel.loadEventProducts(eventId: eventId)
    }
    
    func numberOfProducts() -> Int {
        return collectionModel.count
    }
    
    func bind(collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: Constants.cellId)
        
        self.collectionView = collectionView
    }
}

// MARK: - CollectionView related methods
extension BroadcastEventProductsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModel.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellController(forItemAt: indexPath).view(in: collectionView, at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellWidth, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        loadingControllers[indexPath]?.releaseCellForReuse()
        loadingControllers[indexPath] = nil
    }
    
    private func cellController(forItemAt indexPath: IndexPath) -> ProductCellController {
        let controller = collectionModel[indexPath.item]
        loadingControllers[indexPath] = controller
        return controller
    }
}
