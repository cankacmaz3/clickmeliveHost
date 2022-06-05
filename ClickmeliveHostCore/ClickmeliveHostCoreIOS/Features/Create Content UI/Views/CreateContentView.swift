//
//  CreateContentView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 2.06.2022.
//

import UIKit

public final class CreateContentView: UIView, Layoutable {
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .white
        
        return tv
    }()
    
    public func setupViews() {
        backgroundColor = .white
        
        addSubview(tableView)
    }
    
    public func setupLayout() {
        tableView.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
