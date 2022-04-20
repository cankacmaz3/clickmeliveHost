//
//  ListEventsViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import Foundation
import UIKit

public final class ListEventsViewController: UIViewController, Layouting {
  
    private enum Constants {
        static let eventCellId: String = "\(EventCell.self)"
        static let categoryCellId: String = "\(EventCategoryCell.self)"
        static let tableViewCellHeight: CGFloat = 160.0
    }
    
    public typealias ViewType = ListEventsView
    
    private var refreshController: ListEventsRefreshController?
    
    private var loadingEventCategoryControllers = [IndexPath: EventCategoryCellController]()
        
    private var collectionModel = [EventCategoryCellController]() {
        didSet {
            layoutableView.categoryCollectionView.reloadData()
            layoutableView.categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
    
    private var loadingListCellControllers = [IndexPath: ListEventCellController]()
        
    private var tableModel = [ListEventCellController]() {
        didSet { layoutableView.listEventsTableView.reloadData() }
    }
    
    public convenience init(refreshController: ListEventsRefreshController) {
        self.init()
        self.refreshController = refreshController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        refreshController?.refresh()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    public func display(categories: [EventCategoryCellController]) {
        loadingEventCategoryControllers = [:]
        collectionModel = categories
    }
    
    public func display(_ cellControllers: [ListEventCellController]) {
        loadingListCellControllers = [:]
        tableModel = cellControllers
    }
    
    public func observeCategories() {
        
    }
    
    private func setupCollectionView() {
        layoutableView.categoryCollectionView.delegate = self
        layoutableView.categoryCollectionView.dataSource = self
        layoutableView.categoryCollectionView.register(EventCategoryCell.self, forCellWithReuseIdentifier: Constants.categoryCellId)
        layoutableView.categoryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func setupTableView() {
        layoutableView.listEventsTableView.refreshControl = refreshController?.view
        layoutableView.listEventsTableView.delegate = self
        layoutableView.listEventsTableView.dataSource = self
        layoutableView.listEventsTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layoutableView.listEventsTableView.register(EventCell.self, forCellReuseIdentifier: Constants.eventCellId)
    }
}

// MARK: - TableView related methods
extension ListEventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellController(forRowAt: indexPath).view(in: tableView)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadingListCellControllers[indexPath]?.releaseCellForReuse()
        loadingListCellControllers[indexPath] = nil
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableModel[indexPath.row].select()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewCellHeight
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == tableModel.count - 4 {
            refreshController?.onNext()
        }
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> ListEventCellController {
        let controller = tableModel[indexPath.row]
        loadingListCellControllers[indexPath] = controller
        return controller
    }
}

// MARK: - CollectionView related methods
extension ListEventsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModel.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellController(forItemAt: indexPath).view(in: collectionView, at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        refreshController?.refresh()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        loadingEventCategoryControllers[indexPath]?.releaseCellForReuse()
        loadingEventCategoryControllers[indexPath] = nil
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionModel[indexPath.item].sizeForItemAtIndexPath(in: collectionView)
    }
    
    private func cellController(forItemAt indexPath: IndexPath) -> EventCategoryCellController {
        let controller = collectionModel[indexPath.item]
        loadingEventCategoryControllers[indexPath] = controller
        return controller
    }
}
