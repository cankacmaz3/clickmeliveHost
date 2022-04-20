//
//  UICollectionView+Dequeueing.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 20.04.2022.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
