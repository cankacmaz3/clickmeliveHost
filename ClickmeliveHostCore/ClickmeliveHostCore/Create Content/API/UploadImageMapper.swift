//
//  UploadImageMapper.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//


import Foundation

public final class UploadImageMapper {
    
    private struct UploadImageDTO: Decodable {
        private let url: String?
        
        func toDomain() -> UploadImage {
            return .init(url: url)
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private static var CREATED_201: Int { return 201 }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> UploadImage {
        guard response.statusCode == CREATED_201,
            let root = try? JSONDecoder().decode(UploadImageDTO.self, from: data) else {
                throw Error.invalidData
        }
        
        return root.toDomain()
    }
    
}
