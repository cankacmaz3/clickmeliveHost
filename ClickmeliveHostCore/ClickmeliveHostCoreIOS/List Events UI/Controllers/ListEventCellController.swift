//
//  ListEventCellController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import UIKit
import ClickmeliveHostCore

public final class ListEventCellController {
    
    private let viewModel: EventViewModel
    
    public init(viewModel: EventViewModel) {
        self.viewModel = viewModel
    }
    
    private var cell: EventCell?
    
    func view(in tableView: UITableView) -> UITableViewCell {
        return binded(cell: tableView.dequeueReusableCell())
    }
    
    func select() {
        viewModel.select()
    }
    
    private func binded(cell: EventCell) -> EventCell {
        self.cell = cell
        cell.configure(with: viewModel)
        return cell
    }
    
    func releaseCellForReuse() {
        cell = nil
    }
}

