//
//  VideoContentViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 7.06.2022.
//

import Combine
import Foundation

public final class VideoContentViewModel {
    private var disposables = Set<AnyCancellable>()
    
    public typealias Observer<T> = PassthroughSubject<T, Never>
    
    private let eventCategoryLoader: EventCategoryLoader
    private let eventCreator: EventCreator
    private let imageURLCreator: ImageURLCreator
    private let videoURLCreator: ImageURLCreator
    
    public init(eventCategoryLoader: EventCategoryLoader,
                eventCreator: EventCreator,
                imageURLCreator: ImageURLCreator,
                videoURLCreator: ImageURLCreator) {
        self.eventCategoryLoader = eventCategoryLoader
        self.eventCreator = eventCreator
        self.imageURLCreator = imageURLCreator
        self.videoURLCreator = videoURLCreator
    }
    
    private var maximumVideoMBForUploading: Int { return 100 }
    private var maximumImageMBForUploading: Int { return 2 }
    
    public var onError = Observer<String>()
    public var onCategoriesLoaded = Observer<[EventCategory]>()
    
    public var navigationTitle: String {
        Localized.VideoContent.navigationTitle
    }
    
    public var videoName: String {
        Localized.VideoContent.videoName
    }
    
    public var videoNamePlaceholder: String {
        Localized.VideoContent.videoNamePlaceholder
    }
    
    public var category: String {
        Localized.VideoContent.category
    }
    
    public var categoryPlaceholder: String {
        Localized.VideoContent.categoryPlaceholder
    }
    
    public var tags: String {
        Localized.VideoContent.tags
    }
    
    public var tagsPlaceholder: String {
        Localized.VideoContent.tagsPlaceholder
    }
    
    public var addVideos: String {
        Localized.VideoContent.addVideos
    }
    
    public var addVideoMessage: String {
        Localized.VideoContent.addVideoMessage
    }
    
    public var coverPhoto: String {
        Localized.VideoContent.coverPhoto
    }
    
    public var addPhoto: String {
        Localized.VideoContent.addPhoto
    }
    
    public var maximumMBAlert: String {
        Localized.VideoContent.maxMBAlert
    }
    
    public var ratioAlert: String {
        Localized.VideoContent.ratioAlert
    }
    
    public var categorySelect: String {
        Localized.VideoContent.categorySelect
    }
    
    public var approve: String {
        Localized.VideoContent.approve
    }
    
    public var imageAlert: String {
        Localized.VideoContent.imageAlert
    }
    
    public func validateFile(url: URL) -> Bool {
        guard url.fileSize / 1000000 <= maximumVideoMBForUploading else {
            onError.send(maximumMBAlert)
            return false
        }
        return true
    }
    
    public func validateImageDataSize(data: Data?) -> Bool {
        guard let data = data else { return false }
        let size = Int64(data.count)
        print("image size \(size / 1000000)")
        
        if size / 1000000 <= maximumImageMBForUploading {
            return true
        } else {
            onError.send(imageAlert)
            return false
        }
    }
    
    public func validateVideoSize(width: Double, height: Double) -> Bool {
        guard width/height == 0.5625 else {
            onError.send(ratioAlert)
            return false
        }
        return true
    }
    
    public func loadCategories() {
        eventCategoryLoader.load().sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished: break
                    
                case let .failure(error):
                    self.onError.send(error.localizedDescription)
                }
        }, receiveValue: { [weak self] categories in
            self?.onCategoriesLoaded.send(categories)
        }).store(in: &disposables)
    }
    
    public func createVideoEvent(title: String, categoryId: Int?, products: [Int], tags: [String], uploadImageData: Data?, uploadVideoURL: URL?) {
        guard let uploadVideoURL = uploadVideoURL else { return }
        guard let imageData = uploadImageData else { return }
        guard let videoData =  try? Data(contentsOf: uploadVideoURL) else { return }
        
        Publishers.Zip(imageURLCreator.load(data: imageData), videoURLCreator.load(data: videoData)).sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] (uploadedImage, uploadedVideo) in
                guard let imageUrl = uploadedImage.url else { return }
                guard let videoUrl = uploadedVideo.url else { return }
                self?.createVideo(title: title, categoryId: categoryId, products: products, tags: tags, imageURL: imageUrl, videoURL: videoUrl)
        }).store(in: &disposables)
        
    }
    
    public func createVideo(title: String, categoryId: Int?, products: [Int], tags: [String], imageURL: String, videoURL: String) {
        guard let categoryId = categoryId else {
            return
        }

        eventCreator.createVideo(isActive: true, status: .LONG_VIDEO, title: title, categoryId: categoryId, image: imageURL, video: videoURL, products: products, tags: tags).sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished: break
                    
                case let .failure(error):
                    self.onError.send(error.localizedDescription)
                }
        }, receiveValue: { [weak self] event in
            print("success",  event)
        }).store(in: &disposables)
    }
}

