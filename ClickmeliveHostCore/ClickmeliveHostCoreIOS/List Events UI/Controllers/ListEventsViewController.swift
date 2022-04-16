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
        static let cellId: String = "\(EventCell.self)"
    }
    
    public typealias ViewType = ListEventsView
    
    private var refreshController: ListEventsRefreshController?
    private var loadingControllers = [IndexPath: ListEventCellController]()
        
    private var tableModel = [ListEventCellController]() {
        didSet { layoutableView.listEventsTableView.reloadData() }
    }
    
    public convenience init(refreshController: ListEventsRefreshController) {
        self.init()
        self.refreshController = refreshController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
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
    
    public func display(_ cellControllers: [ListEventCellController]) {
        loadingControllers = [:]
        tableModel = cellControllers
    }
    
    private func setupTableView() {
        layoutableView.listEventsTableView.refreshControl = refreshController?.view
        layoutableView.listEventsTableView.delegate = self
        layoutableView.listEventsTableView.dataSource = self
        layoutableView.listEventsTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        layoutableView.listEventsTableView.register(EventCell.self, forCellReuseIdentifier: Constants.cellId)
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
        loadingControllers[indexPath]?.releaseCellForReuse()
        loadingControllers[indexPath] = nil
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableModel[indexPath.row].select()
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> ListEventCellController {
        let controller = tableModel[indexPath.row]
        loadingControllers[indexPath] = controller
        return controller
    }
}
