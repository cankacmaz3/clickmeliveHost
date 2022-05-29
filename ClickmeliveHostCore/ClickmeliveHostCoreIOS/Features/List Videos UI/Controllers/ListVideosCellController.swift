//
//  ListVideosCellController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import UIKit
import ClickmeliveHostCore

public final class ListVideosCellController {
    
    private let viewModel: EventViewModel
    private let imageLoader: ImageLoader
    
    public let selection: () -> Void
    
    public init(viewModel: EventViewModel,
                imageLoader: ImageLoader,
                selection: @escaping () -> Void) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
        self.selection = selection
    }
    
    private var cell: ListVideoCell?
    
    func view(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        return binded(cell: collectionView.dequeueReusableCell(indexPath: indexPath))
    }
    
    private func binded(cell: ListVideoCell) -> ListVideoCell {
        self.cell = cell
        cell.configure(with: viewModel, imageLoader: imageLoader)
        return cell
    }
    
    func releaseCellForReuse() {
        cell = nil
    }
}
