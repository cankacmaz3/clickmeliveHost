//
//  ListProductCellController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 7.06.2022.
//

import ClickmeliveHostCore
import UIKit

public final class ListProductCellController {
    
    public let viewModel: ProductViewModel
    public var isSelected: Bool = false
    private let imageLoader: ImageLoader
    
    public init(viewModel: ProductViewModel,
                imageLoader: ImageLoader) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
    }
    
    private var cell: ListProductCell?
    
    func view(in tableView: UITableView) -> UITableViewCell {
        return binded(cell: tableView.dequeueReusableCell())
    }
    
    private func binded(cell: ListProductCell) -> ListProductCell {
        self.cell = cell
        cell.configure(with: viewModel, imageLoader: imageLoader, isSelected: isSelected)
        
        return cell
    }
    
    func releaseCellForReuse() {
        cell = nil
    }
}
