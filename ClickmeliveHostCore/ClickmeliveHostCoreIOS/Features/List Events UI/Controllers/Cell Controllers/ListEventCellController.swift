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
    public let selection: () -> Void
    
    public init(viewModel: EventViewModel,
                selection: @escaping () -> Void) {
        self.viewModel = viewModel
        self.selection = selection
    }
    
    private var cell: EventCell?
    
    func view(in tableView: UITableView) -> UITableViewCell {
        return binded(cell: tableView.dequeueReusableCell())
    }
    
    private func binded(cell: EventCell) -> EventCell {
        self.cell = cell
        cell.configure(with: viewModel)
        
        cell.onStartBroadcastTapped = { [weak self] in
            self?.selection()
        }
        
        return cell
    }
    
    func releaseCellForReuse() {
        cell = nil
    }
}

