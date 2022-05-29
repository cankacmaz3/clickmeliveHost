//
//  ListVideosViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation
import UIKit

public final class ListVideosViewController: UIViewController, Layouting {
  
    private enum Constants {
        static let listVideoCellId: String = "\(ListVideoCell.self)"
    }
    
    public typealias ViewType = ListVideosView
    
    private var refreshController: ListVideosRefreshController?
    
    private var collectionModel = [ListVideosCellController]() {
        didSet { layoutableView.collectionView.reloadData() }
    }
    
    private var loadingControllers = [IndexPath: ListVideosCellController]()
    
    public convenience init(refreshController: ListVideosRefreshController) {
        self.init()
        self.refreshController = refreshController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCollectionView()
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    public func display(_ controllers: [ListVideosCellController]) {
        loadingControllers = [:]
        collectionModel = controllers
    }
    
    public func deleteTapped(eventId: Int) {
        refreshController?.deleteEvent(eventId: eventId)
    }
    
    public func reloadCollectionView() {
        collectionModel = []
        refreshController?.refresh()
    }
    
    private func setupCollectionView() {
        layoutableView.collectionView.refreshControl = refreshController?.view
        layoutableView.collectionView.delegate = self
        layoutableView.collectionView.dataSource = self
        layoutableView.collectionView.register(ListVideoCell.self, forCellWithReuseIdentifier: Constants.listVideoCellId)
        layoutableView.collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
}

// MARK: - CollectionView related methods
extension ListVideosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModel.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellController(forItemAt: indexPath).view(in: collectionView, at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 32 - 10) / 2
        let height = width * 1.7
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionModel[indexPath.item].selection()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        loadingControllers[indexPath]?.releaseCellForReuse()
        loadingControllers[indexPath] = nil
    }
    
    private func cellController(forItemAt indexPath: IndexPath) -> ListVideosCellController {
        let controller = collectionModel[indexPath.item]
        loadingControllers[indexPath] = controller
        return controller
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
