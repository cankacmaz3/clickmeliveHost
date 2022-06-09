//
//  ContentViewController.swift
//  ClickmeliveHostCoreIOS
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit
import Combine
import AVFoundation
import ClickmeliveHostCore
import IQKeyboardManagerSwift

public final class ContentViewController: UIViewController, Layouting {
    
    public typealias ViewType = ContentView
    
    public var onAddProductSelected = PassthroughSubject<[ProductViewModel], Never>()
    public var onAddVideoSelected = PassthroughSubject<Void, Never>()
    public var onPlayVideoSelected = PassthroughSubject<URL, Never>()
    public var onAddCoverPhotoSelected = PassthroughSubject<Void, Never>()
    
    private let editingEvent: EventViewModel?
    private let viewModel: ContentViewModel
    private let contentType: CMLContentType
    
    public init(editingEvent: EventViewModel?,
                viewModel: ContentViewModel,
                contentType: CMLContentType) {
        self.editingEvent = editingEvent
        self.viewModel = viewModel
        self.contentType = contentType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        layoutableView.setupContent(type: contentType)
        
        setLocalizedTitles()
        registerActions()
       
        initializations()
        
        switch contentType {
        case .livestream:
            viewModel.loadgroups()
        case .video:
            viewModel.loadCategories()
        }
        
    }
    
    deinit {
        print("deinit VideoContentViewController")
    }
    
    public override func loadView() {
        view = ViewType.create()
    }
    
    private func initializations() {
        guard let editingEvent = editingEvent else {
            return
        }
        
        layoutableView.populate(with: editingEvent)
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
        layoutableView.categoriesPickerView.populate(with: categories)
    }
    
    public func loadGroups(groups: [EventGroup]) {
        layoutableView.groupsPickerView.populate(with: groups)
    }
    
    @objc private func approveTapped() {
        let title = contentType == .video ? layoutableView.tfVideoName.text ?? "": layoutableView.tfLivestreamTitle.text ?? ""
        let contentId = contentType == .video ? layoutableView.categoriesPickerView.getSelectedCategoryId() : layoutableView.groupsPickerView.getSelectedGroupId()
        let tags = layoutableView.tfTags.tags.map { $0.text }
        let videoURL = layoutableView.addVideoView.fileURL
        let coverImage = layoutableView.addVideoView.image
        let addedProducts = layoutableView.listProductsView.selectedProductIds()
        let status: Event.EventStatus = contentType == .video ? .LONG_VIDEO: .UPCOMING
        let startingDate = contentType == .video ? nil : layoutableView.startingDateView.getSelectedDate()
        
        viewModel.createEvent(status: status ,title: title, contentId: contentId, products: addedProducts, tags: tags, uploadImageData: coverImage?.pngData(), uploadVideoURL: videoURL, startingDate: startingDate)
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

extension ContentViewController: ListProductsDelegate {
    public func selectedProducts(products: [ProductViewModel]) {
        layoutableView.listProductsView.display(products: products)
    }
}
