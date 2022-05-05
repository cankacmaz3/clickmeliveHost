//
//  ChatCellController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 3.05.2022.
//

import UIKit
import ClickmeliveHostCore

public final class ChatCellController {
    
    private let viewModel: ChatViewModel
    private var cell: ChatCell?
    
    public init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        return binded(cell: tableView.dequeueReusableCell())
    }
    
    private func binded(cell: ChatCell) -> ChatCell {
        self.cell = cell
        cell.configure(with: viewModel)
        return cell
    }
    
    func releaseCellForReuse() {
        cell = nil
    }
}

