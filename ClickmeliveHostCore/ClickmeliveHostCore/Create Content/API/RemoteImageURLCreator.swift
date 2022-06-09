//
//  RemoteImageURLCreator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Foundation
import Combine

public final class RemoteImageURLCreator: RemoteClient<UploadImage>, ImageURLCreator {
    public func load(data: Data) -> AnyPublisher<UploadImage, Error> {
        let endPoint = baseURL.appendingPathComponent("api/v1/upload/event/image")
        let multipartDataRequest = MultipartFormDataRequest(url: endPoint)
        multipartDataRequest.addDataField(named: "file", data: data, mimeType: "image/png")
        
        return loadPublisher(urlRequest: multipartDataRequest.asURLRequest(), mapper: UploadImageMapper.map)
    }
}

public final class RemoteVideoURLCreator: RemoteClient<UploadImage>, ImageURLCreator {
    public func load(data: Data) -> AnyPublisher<UploadImage, Error> {
        let endPoint = baseURL.appendingPathComponent("api/v1/upload/event/video")
        let multipartDataRequest = MultipartFormDataRequest(url: endPoint)
        multipartDataRequest.addDataField(named: "file", data: data, mimeType: "video/mp4")
        
        return loadPublisher(urlRequest: multipartDataRequest.asURLRequest(), mapper: UploadImageMapper.map)
    }
}
