//
//  VideoContentUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import UIKit
import Foundation
import Combine
import YPImagePicker
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class VideoContentUIComposer {
    private init() {}
    
    private static var disposables = Set<AnyCancellable>()
    
    static func makeVideoContentViewController(event: Event?) -> VideoContentViewController {
        let router = VideoContentRouter()
        
        print(event, "here event")
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let authTokenLoader = AuthTokenLoader(store: AuthTokenStore())
        
        let eventCategoryLoader = RemoteEventCategoryLoader(client: loadingClient, baseURL: AppEnvironment.baseURL, authTokenLoader: authTokenLoader)
        
        let viewModel = VideoContentViewModel(eventCategoryLoader: eventCategoryLoader)
        let controller = VideoContentViewController(viewModel: viewModel)
        router.viewController = controller
        
        viewModel.onError.sink(receiveValue: { message in
            router.openAlertModule(message: message)
        }).store(in: &disposables)
        
        viewModel.onCategoriesLoaded.sink(receiveValue: { [weak controller] categories in
            controller?.loadCategories(categories: categories)
        }).store(in: &disposables)
        
        controller.onAddProductSelected.sink(receiveValue: { [weak controller] productViewModels in
            router.openListProductModule(selectedProducts: productViewModels, delegate: controller)
        }).store(in: &disposables)
        
        controller.onPlayVideoSelected.sink(receiveValue: { url in
            router.openVideoModule(url: url)
        }).store(in: &disposables)
        
        controller.onAddVideoSelected.sink(receiveValue: { [weak controller] in
            FileManager.default.clearTmpDirectory()
            var config = YPImagePickerConfiguration()
            config.screens = [.library]
            config.library.mediaType = .video
            config.video.libraryTimeLimit = 90
            config.onlySquareImagesFromCamera = false
            
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, _ in
                picker.dismiss(animated: true, completion: {
                    if let video = items.singleVideo {
                        let resizedImage = resizeImage(image: video.thumbnail, newWidth: 450)
                        controller?.validateVideo(fileURL: video.url, coverImage: resizedImage)
                    }
                })
            }
            controller?.present(picker, animated: true, completion: nil)
        }).store(in: &disposables)
        
        controller.onAddCoverPhotoSelected.sink(receiveValue: { [weak controller] in
            var config = YPImagePickerConfiguration()
            config.screens = [.library]
            config.showsCrop = .rectangle(ratio: 9/16)
            config.targetImageSize = .cappedTo(size: 800)
            config.showsPhotoFilters = false
            config.shouldSaveNewPicturesToAlbum = false
            
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    controller?.setCoverPhoto(coverImage: photo.image)
                }
                picker.dismiss(animated: true, completion: nil)
            }
            controller?.present(picker, animated: true, completion: nil)
        }).store(in: &disposables)
        
        return controller
    }
    
    private static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}

extension FileManager {
    func clearTmpDirectory() {
        do {
            let tmpDirectory = try contentsOfDirectory(atPath: NSTemporaryDirectory())
            try tmpDirectory.forEach {[unowned self] file in
                let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
                try self.removeItem(atPath: path)
            }
        } catch {
            print(error)
        }
    }
}

