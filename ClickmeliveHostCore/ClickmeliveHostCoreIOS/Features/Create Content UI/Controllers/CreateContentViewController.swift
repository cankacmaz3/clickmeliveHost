//
//  CreateContentViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 2.06.2022.
//

import UIKit
import ClickmeliveHostCore

public final class CreateContentViewController: UIViewController, Layouting {
    
    private enum Constants {
        static let cellId: String = "\(CreateContentCell.self)"
        static let cellHeight: CGFloat = 56.0
    }
    
    public typealias ViewType = CreateContentView
    
    private let viewModel: CreateContentViewModel
    
    public init(viewModel: CreateContentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private var tableModel = [SelectContentViewModel]() {
        didSet { layoutableView.tableView.reloadData() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.navigationTitle
        configureTableView()
    }
    
    deinit {
        print("deinit CreateContentViewController")
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    public func display(contents: [SelectContentViewModel]) {
        tableModel = contents
    }
    
    private func configureTableView() {
        layoutableView.tableView.delegate = self
        layoutableView.tableView.dataSource = self
        layoutableView.tableView.register(CreateContentCell.self, forCellReuseIdentifier: Constants.cellId)
        layoutableView.tableView.rowHeight = Constants.cellHeight
    }
}

// MARK: - TableView related methods
extension CreateContentViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CreateContentCell = tableView.dequeueReusableCell()
        let title = tableModel[indexPath.row].getLocalizedTitle
        cell.setTitle(title)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableModel[indexPath.row].select()
    }
}
