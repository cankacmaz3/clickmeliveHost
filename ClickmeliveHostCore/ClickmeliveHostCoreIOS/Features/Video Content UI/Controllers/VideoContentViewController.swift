//
//  VideoContentViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit
import Combine
import AVFoundation
import ClickmeliveHostCore
import IQKeyboardManagerSwift

public final class VideoContentViewController: UIViewController, Layouting {
    
    public typealias ViewType = VideoContentView
    
    public var onAddProductSelected = PassthroughSubject<[ProductViewModel], Never>()
    public var onAddVideoSelected = PassthroughSubject<Void, Never>()
    public var onPlayVideoSelected = PassthroughSubject<URL, Never>()
    public var onAddCoverPhotoSelected = PassthroughSubject<Void, Never>()
    
    private var categories: [EventCategory] = []
    
    private let viewModel: VideoContentViewModel
    
    public init(viewModel: VideoContentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setLocalizedTitles()
        registerActions()
        setupCategories()
        
        viewModel.loadCategories()
    }
    
    deinit {
        print("deinit VideoContentViewController")
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    public func validateVideo(fileURL: URL, coverImage: UIImage?) {
        let videoSize = resolutionForLocalVideo(url: fileURL)
        let validateFile = viewModel.validateFile(url: fileURL)
        let validateImage = viewModel.validateImageDataSize(data: coverImage?.pngData())
        let validateVideoSize = viewModel.validateVideoSize(width: Double(abs(videoSize.width)),
                                                            height: Double(abs(videoSize.height)))
        
        if  validateVideoSize == true && validateFile == true && validateImage == true {
            layoutableView.addVideoView.setVideo(fileURL: fileURL, image: coverImage)
        }
    }
    
    public func setCoverPhoto(coverImage: UIImage) {
        let validateImage = viewModel.validateImageDataSize(data: coverImage.pngData())
        if validateImage == true {
            layoutableView.addVideoView.setImage(image: coverImage)
        }
    }
    
    public func loadCategories(categories: [EventCategory]) {
        self.categories = categories
    }
    
    @objc private func approveTapped() {
        let title = layoutableView.tfVideoName.text ?? ""
        let categoryId = getSelectedCategoryId()
        let tags = layoutableView.tfTags.tags.map { $0.text }
        let videoURL = layoutableView.addVideoView.fileURL
        let coverImage = layoutableView.addVideoView.image
        let addedProducts = layoutableView.listProductsView.selectedProductIds()
        
        viewModel.createVideoEvent(title: title, categoryId: categoryId, products: addedProducts, tags: tags, uploadImageData: coverImage?.pngData(), uploadVideoURL: videoURL)
    }
    
    private func getSelectedCategoryId() -> Int? {
        guard !categories.isEmpty else { return nil }
        let selectedCategory = categories[layoutableView.pickerView.selectedRow(inComponent: 0)]
        return selectedCategory.id
    }
    
    @objc private func categorySelected() {
        layoutableView.tfCategories.resignFirstResponder()
        
        guard !categories.isEmpty else { return }
        
        let selectedCategory = categories[layoutableView.pickerView.selectedRow(inComponent: 0)]
        layoutableView.tfCategories.text = selectedCategory.name
    }
    
    private func registerActions() {
        layoutableView.listProductsView.onAddProductTapped = { [weak self] productViewModels in
            self?.onAddProductSelected.send(productViewModels)
        }
        
        layoutableView.addVideoView.onAddVideoTapped = { [weak self] in
            self?.onAddVideoSelected.send()
        }
        
        layoutableView.addVideoView.onPlayVideoTapped = { [weak self] url in
            self?.onPlayVideoSelected.send(url)
        }
        
        layoutableView.addVideoView.onAddCoverPhotoTapped = { [weak self] in
            self?.onAddCoverPhotoSelected.send()
        }
        
        layoutableView.btnApprove.addTarget(self, action: #selector(approveTapped), for: .touchUpInside)
        layoutableView.tfCategories.addRightButtonOnKeyboardWithText(viewModel.categorySelect, target: self, action: #selector(categorySelected))
    }
    
    private func setupCategories() {
        layoutableView.pickerView.delegate = self
        layoutableView.pickerView.dataSource = self
    }
    
    private func setLocalizedTitles() {
        navigationItem.title = viewModel.navigationTitle
        layoutableView.setLocalizedTitles(viewModel: viewModel)
    }
    
    private func resolutionForLocalVideo(url: URL) -> CGSize {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return .zero }
        let size = track.naturalSize.applying(track.preferredTransform)
        print("Resolution size", size)
        return size
    }
}

extension VideoContentViewController: ListProductsDelegate {
    public func selectedProducts(products: [ProductViewModel]) {
        layoutableView.listProductsView.display(products: products)
    }
}

extension VideoContentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
}
