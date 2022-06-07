//
//  ListProductsViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit
import ClickmeliveHostCore

public protocol ListProductsDelegate {
    func selectedProducts(products: [ProductViewModel])
}

public final class ListProductsViewController: UIViewController, Layouting {
    
    private enum Constants {
        static let cellId: String = "\(ListProductCell.self)"
        static let tableViewCellHeight: CGFloat = 98
    }
    
    public typealias ViewType = ListProductsView
    public var delegate: ListProductsDelegate?
    public var onSaveTapped: (() -> Void)?
    public var onExceededMaxProductAmount: ((String) -> Void)?
    
    private var maximumNumberOfProducts: Int = 25
    
    private let viewModel: ListProductsViewModel
    
    public init(viewModel: ListProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var selectedViewModels = Set<ProductViewModel>() {
        didSet {
            navigationItem.title = viewModel.updateNavigationTitle(selectedProductCount: selectedViewModels.count)
        }
    }
    
    private var loadingControllers = [IndexPath: ListProductCellController]()
    
    private var currentControllers = [ListProductCellController]() {
        didSet { layoutableView.tableView.reloadData() }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupSearchBar()
        viewModel.loadProducts()
    }
    
    deinit {
        print("deinit ListProductsViewController")
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    public func display(_ cellControllers: [ListProductCellController] , selectedProducts: [ProductViewModel]) {
        loadingControllers = [:]
        selectedProducts.forEach { selectedViewModels.insert($0) }
        currentControllers = cellControllers
    }
    
    @objc private func saveTapped() {
        let products = selectedViewModels.map { $0 }
        delegate?.selectedProducts(products: products)
        
        onSaveTapped?()
    }
    
    private func setupTableView() {
        layoutableView.tableView.delegate = self
        layoutableView.tableView.dataSource = self
        layoutableView.tableView.rowHeight = Constants.tableViewCellHeight
        layoutableView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        layoutableView.tableView.register(ListProductCell.self, forCellReuseIdentifier: Constants.cellId)
    }
    
    private func setupSearchBar() {
        layoutableView.searchBar.delegate = self
    }
    
    private func setupUI() {
        layoutableView.setLocalizedTitles(viewModel: viewModel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.save, style: .plain, target: self, action: #selector(saveTapped))
    
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: Fonts.semibold, size: 17)!,
            NSAttributedString.Key.foregroundColor : Colors.primary,
        ], for: .normal)
        
        navigationItem.title = viewModel.updateNavigationTitle(selectedProductCount: selectedViewModels.count)
    }
}

extension ListProductsViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.loadProducts()
            searchBar.resignFirstResponder()
        }
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadProducts(with: searchBar.text)
    }
}

extension ListProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentControllers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellController = cellController(forRowAt: indexPath)
        cellController.isSelected = selectedViewModels.contains(cellController.viewModel)
        return cellController.view(in: tableView)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadingControllers[indexPath]?.releaseCellForReuse()
        loadingControllers[indexPath] = nil
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewCellHeight
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == currentControllers.count - 4 {
            viewModel.onNextProduct()
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentProductViewModel = currentControllers[indexPath.row].viewModel
        if selectedViewModels.contains(currentProductViewModel) {
            selectedViewModels.remove(currentProductViewModel)
        } else {
            guard selectedViewModels.count < maximumNumberOfProducts else {
                onExceededMaxProductAmount?(viewModel.exceededMaximumProductAlert)
                return
            }
            selectedViewModels.insert(currentProductViewModel)
        }
        
        layoutableView.tableView.reloadData()
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> ListProductCellController {
        let controller = currentControllers[indexPath.row]
        loadingControllers[indexPath] = controller
        return controller
    }
}
