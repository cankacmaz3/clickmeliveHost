//
//  BroadcastChatController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 3.05.2022.
//

import UIKit
import ClickmeliveHostCore

public final class BroadcastChatController: NSObject {
    
    private enum Constants {
        static let cellId: String = "\(ChatCell.self)"
    }
    
    var tableView: UITableView?
    
    private var loadingControllers = [IndexPath: ChatCellController]()
        
    private var tableModel = [ChatCellController]() {
        didSet {
            tableView?.reloadData()
            tableView?.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
        }
    }
    
    public func updateCellControllers(_ controller: ChatCellController) {
        tableModel.insert(controller, at: 0)
    }
    
    func bind(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: Constants.cellId)
        
        self.tableView = tableView
    }
}

// MARK: - TableView related methods
extension BroadcastChatController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    private func cellController(forRowAt indexPath: IndexPath) -> ChatCellController {
        let controller = tableModel[indexPath.row]
        loadingControllers[indexPath] = controller
        return controller
    }
}
