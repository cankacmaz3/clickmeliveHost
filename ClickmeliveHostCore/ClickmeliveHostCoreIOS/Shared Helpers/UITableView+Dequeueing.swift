//
//  UITableView+Dequeueing.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 16.04.2022.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T
    }
}

