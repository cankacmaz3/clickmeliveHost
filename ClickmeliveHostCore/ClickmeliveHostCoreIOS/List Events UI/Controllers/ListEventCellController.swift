//
//  ListEventCellController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import UIKit

public final class ListEventCellController {
    
    public init() {}
    
    private var cell: EventCell?
    
    func view(in tableView: UITableView) -> UITableViewCell {
        return binded(cell: tableView.dequeueReusableCell())
    }
    
    private func binded(cell: EventCell) -> EventCell {
        self.cell = cell
        return cell
    }
    
    func releaseCellForReuse() {
        cell = nil
    }
}

