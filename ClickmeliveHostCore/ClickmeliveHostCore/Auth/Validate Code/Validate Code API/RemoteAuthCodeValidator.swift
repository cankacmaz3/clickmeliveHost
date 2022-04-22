//
//  RemoteAuthCodeValidator.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public final class RemoteAuthCodeValidator: AuthCodeValidator {
    
    private let client: HTTPClient
    private let baseURL: URL
    
    public typealias Result = AuthCodeValidator.Result
    
    public init(client: HTTPClient,
                baseURL: URL) {
        self.client = client
        self.baseURL = baseURL
    }
    
    public func perform(validateCodeRequest: ValidateCodeRequest, completion: @escaping (Result) -> Void) {
        let endpoint = AuthEndpoints.verifyCode(verificationCodeId: validateCodeRequest.verificationCodeId,
                                                phone: validateCodeRequest.phone,
                                                code: validateCodeRequest.code)
        client.execute(with: endpoint.urlRequest(baseURL: baseURL)) { result in
            switch result {
            case let .success((data, response)):
                completion(RemoteAuthCodeValidator.map(data, from: response))
            case .failure:
                completion(.failure(.init(message: Localized.Error.defaultMessage)))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        guard response.isOK,
            let root = try? JSONDecoder().decode(ValidateCodeDTO.self, from: data) else {
               
                guard let serverError = try? JSONDecoder().decode(CMLErrorDTO.self, from: data) else {
                    return .failure(.init(message: Localized.Error.defaultMessage))
                }
                print(serverError)
                return .failure(serverError.toDomain())
        }
        
        return .success(root.toDomain())
    }
}

