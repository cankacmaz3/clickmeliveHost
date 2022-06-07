//
//  ListProductsView.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit
import ClickmeliveHostCore

extension ListProductsView {
    func setLocalizedTitles(viewModel: ListProductsViewModel) {
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.font = UIFont(name: Fonts.regular, size: 14)
        
        textFieldInsideUISearchBar?.attributedPlaceholder = NSAttributedString(string: viewModel.searchPlaceholder, attributes: [
            NSAttributedString.Key.foregroundColor: Constants.searchPlaceholderColor,
            NSAttributedString.Key.font: UIFont(name: Fonts.regular, size: 13)!
        ])
    }
}

public final class ListProductsView: UIView, Layoutable {
    
    private enum Constants {
        static let lineColor: UIColor = UIColor.rgb(red: 221, green: 226, blue: 229)
        static let searchPlaceholderColor: UIColor = UIColor.rgb(red: 159, green: 159, blue: 159)
    }
    
    private let topLine: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.lineColor
        return view
    }()
    
    let searchView: UIView = {
        let view = UIView()
        return view
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .white
        
        return tv
    }()
    
    public func setupViews() {
        backgroundColor = .white
        addSubview(topLine)
        
        searchView.addSubview(searchBar)
        addSubview(searchView)
        
        addSubview(tableView)
    }
    
    public func setupLayout() {
        topLine.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        searchView.anchor(topLine.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
     
        searchBar.anchor(searchView.topAnchor, left: searchView.leftAnchor, bottom: searchView.bottomAnchor, right: searchView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        tableView.anchor(searchView.bottomAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
