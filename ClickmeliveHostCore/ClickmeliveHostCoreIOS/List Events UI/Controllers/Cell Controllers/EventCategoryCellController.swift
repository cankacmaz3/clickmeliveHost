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
    
    private let viewModel: EventCategoryCellViewModel
    private var cell: EventCategoryCell?
    
    public init(viewModel: EventCategoryCellViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        return binded(cell: collectionView.dequeueReusableCell(indexPath: indexPath))
    }
    
    func sizeForItemAtIndexPath(in collectionView: UICollectionView) -> CGSize {
        // TODO: Make here auto-sizing
        let text = viewModel.localizedIndex as NSString
        let font = UIFont(name: Fonts.medium, size: 14)
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font!])
        return CGSize(width: size.width + 4, height: collectionView.frame.height)
    }
    
    private func binded(cell: EventCategoryCell) -> EventCategoryCell {
        self.cell = cell
        cell.configure(with: viewModel)
        return cell
    }
    
    func loadEvents(listEventsViewModel: ListEventsViewModel) {
        listEventsViewModel.loadEvents(with: viewModel.status)
    }
    
    func releaseCellForReuse() {
        cell = nil
    }
}
