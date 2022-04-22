//
//  ProductCellController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import UIKit
import ClickmeliveHostCore

public final class ProductCellController {
    
    private var cell: ProductCell?
    private let viewModel: ProductViewModel
    
    public init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        return binded(cell: collectionView.dequeueReusableCell(indexPath: indexPath), index: indexPath.item)
    }
    
    private func binded(cell: ProductCell, index: Int) -> ProductCell {
        self.cell = cell
        cell.configure(with: viewModel, at: index)
        return cell
    }
    
    func releaseCellForReuse() {
        cell = nil
    }
}
