//
//  HomeViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 24.05.2022.
//

import Foundation
import UIKit

public final class HomeViewController: UIViewController, Layouting {
    public typealias ViewType = HomeView
    
    private let listEventsViewController: UIViewController
    private let listVideosViewController: UIViewController
    
    public init(listEventsViewController: UIViewController,
                listVideosViewController: UIViewController) {
        self.listEventsViewController = listEventsViewController
        self.listVideosViewController = listVideosViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutableView.categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        switchContent(destinationVC: listEventsViewController)
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func configureCollectionView() {
        layoutableView.categoryCollectionView.delegate = self
        layoutableView.categoryCollectionView.dataSource = self
        layoutableView.categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    private func switchContent(destinationVC: UIViewController) {
        destinationVC.view.frame = CGRect(
            x: 0,
            y: 0,
            width: layoutableView.contentView.frame.width,
            height: layoutableView.contentView.frame.height
        )
        
        layoutableView.contentView.addSubview(destinationVC.view)
    }
}

// MARK: - CollectionView related methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CategoryCell
        if indexPath.item == 0 {
            cell.configure(with: .init(contentType: .live))
        } else {
            cell.configure(with: .init(contentType: .video))
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            switchContent(destinationVC: listEventsViewController)
        } else {
            switchContent(destinationVC: listVideosViewController)
        }
    }
}
