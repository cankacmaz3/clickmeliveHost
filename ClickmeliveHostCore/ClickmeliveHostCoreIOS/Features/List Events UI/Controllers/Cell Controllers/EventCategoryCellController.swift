//
//  EventCategoryCellController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 20.04.2022.
//

import Foundation
import UIKit
import ClickmeliveHostCore

public final class EventCategoryCellController {
    
    private let viewModel: EventCategoryViewModel
    private var cell: EventCategoryCell?
    
    public init(viewModel: EventCategoryViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        return binded(cell: collectionView.dequeueReusableCell(indexPath: indexPath))
    }
    
    func sizeForItemAtIndexPath(in collectionView: UICollectionView) -> CGSize {
        // TODO: Make here auto-sizing
        let text = viewModel.localizedIndex as NSString
        let font = UIFont(name: Fonts.semibold, size: 12)
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font!])
        return CGSize(width: size.width + 40, height: collectionView.frame.height)
    }
    
    private func binded(cell: EventCategoryCell) -> EventCategoryCell {
        self.cell = cell
        cell.configure(with: viewModel)
        return cell
    }
    
    func status() -> Event.EventStatus {
        return viewModel.status
    }
    
    func releaseCellForReuse() {
        cell = nil
    }
}
