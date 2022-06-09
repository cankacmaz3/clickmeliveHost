//
//  ContentViewModel.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 7.06.2022.
//

import Combine
import Foundation

public final class ContentViewModel {
    private var disposables = Set<AnyCancellable>()
    
    public typealias Observer<T> = PassthroughSubject<T, Never>
    
    private let eventCategoryLoader: EventCategoryLoader
    private let eventGroupLoader: EventGroupLoader
    private let eventCreator: EventCreator
    private let imageURLCreator: ImageURLCreator
    private let videoURLCreator: ImageURLCreator
    
    public init(eventCategoryLoader: EventCategoryLoader,
                eventGroupLoader: EventGroupLoader,
                eventCreator: EventCreator,
                imageURLCreator: ImageURLCreator,
                videoURLCreator: ImageURLCreator) {
        self.eventCategoryLoader = eventCategoryLoader
        self.eventGroupLoader = eventGroupLoader
        self.eventCreator = eventCreator
        self.imageURLCreator = imageURLCreator
        self.videoURLCreator = videoURLCreator
    }
    
    private var maximumVideoMBForUploading: Int { return 100 }
    private var maximumImageMBForUploading: Int { return 2 }
    
    public var onError = Observer<String>()
    public var onCategoriesLoaded = Observer<[EventCategory]>()
    public var onGroupsLoaded = Observer<[EventGroup]>()
    public var onEventCreated = Observer<Void>()
    
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
    
    public func loadgroups() {
        eventGroupLoader.load().sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished: break
                    
                case let .failure(error):
                    self.onError.send(error.localizedDescription)
                }
        }, receiveValue: { [weak self] groups in
            self?.onGroupsLoaded.send(groups)
        }).store(in: &disposables)
    }
    
    public func createEvent(status: Event.EventStatus, title: String, contentId: Int?, products: [Int], tags: [String], uploadImageData: Data?, uploadVideoURL: URL?, startingDate: Date?) {
        guard let uploadVideoURL = uploadVideoURL else { return }
        guard let imageData = uploadImageData else { return }
        guard let videoData =  try? Data(contentsOf: uploadVideoURL) else { return }
        
        var startingDateString: String? = nil
        if let startingDate = startingDate {
            startingDateString =  DateFormatter.yyyyMMddTHHmmssSSSZ.string(from: startingDate)
        }
        
        Publishers.Zip(imageURLCreator.load(data: imageData), videoURLCreator.load(data: videoData)).sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] (uploadedImage, uploadedVideo) in
                guard let imageUrl = uploadedImage.url else { return }
                guard let videoUrl = uploadedVideo.url else { return }
                
                self?.create(status: status, title: title, contentId: contentId, products: products, tags: tags, imageURL: imageUrl, videoURL: videoUrl, startingDate: startingDateString)
        }).store(in: &disposables)
        
    }
    
    public func create(status: Event.EventStatus, title: String, contentId: Int?, products: [Int], tags: [String], imageURL: String, videoURL: String, startingDate: String?) {
        guard let contentId = contentId else {
            return
        }

        eventCreator.createVideo(isActive: true, status: status, title: title, contentId: contentId, image: imageURL, video: videoURL, products: products, tags: tags, startingDate: startingDate).sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished: break
                    
                case let .failure(error):
                    self.onError.send(error.localizedDescription)
                }
        }, receiveValue: { [weak self] _ in
            self?.onEventCreated.send()
        }).store(in: &disposables)
    }
}


extension ContentViewModel {
    public var navigationTitle: String {
        Localized.Content.videoNavigationTitle
    }
    
    public var videoName: String {
        Localized.Content.videoName
    }
    
    public var videoNamePlaceholder: String {
        Localized.Content.videoNamePlaceholder
    }
    
    public var category: String {
        Localized.Content.category
    }
    
    public var categoryPlaceholder: String {
        Localized.Content.categoryPlaceholder
    }
    
    public var tags: String {
        Localized.Content.tags
    }
    
    public var tagsPlaceholder: String {
        Localized.Content.tagsPlaceholder
    }
    
    public var addVideos: String {
        Localized.Content.addVideos
    }
    
    public var addVideoMessage: String {
        Localized.Content.addVideoMessage
    }
    
    public var coverPhoto: String {
        Localized.Content.coverPhoto
    }
    
    public var addPhoto: String {
        Localized.Content.addPhoto
    }
    
    public var maximumMBAlert: String {
        Localized.Content.maxMBAlert
    }
    
    public var ratioAlert: String {
        Localized.Content.ratioAlert
    }
    
    public var categorySelect: String {
        Localized.Content.categorySelect
    }
    
    public var approve: String {
        Localized.Content.approve
    }
    
    public var imageAlert: String {
        Localized.Content.imageAlert
    }
    
    public var livestreamNavigationTitle: String {
        Localized.Content.livestreamNavigationTitle
    }
    
    public var streamTitle: String {
        Localized.Content.streamTitle
    }
    
    public var streamTitlePlaceholder: String {
        Localized.Content.streamTitlePlaceholder
    }
    
    public var group: String {
        Localized.Content.group
    }
    
    public var groupPlaceholder: String {
        Localized.Content.groupPlaceholder
    }
}
