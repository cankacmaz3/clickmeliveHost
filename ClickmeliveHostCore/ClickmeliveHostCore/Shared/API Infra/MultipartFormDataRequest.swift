//
//  MultipartFormDataRequest.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 9.06.2022.
//

import Foundation

struct MultipartFormDataRequest {
    private var version: String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String }
    private var clientDevice: String { return "IOS" }
    private var versionHeaderField: String { return "Client-Version" }
    private var deviceHeaderField: String { return "Client-Device" }
    private var authorizationHeaderField: String { return "Authorization" }
    private var authorizationValue: String { return "apiKey 617196fc65dc0778fb59e97660856d1921bef5a092bb4071f3c071704e5ca4cc" }
    
    private let boundary: String = UUID().uuidString
    private var httpBody = NSMutableData()
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
    }

    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }

    func addDataField(named name: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
    }

    private func dataFormField(named name: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()

        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\("\(UUID().uuidString)")\"\r\n")
        fieldData.append("Content-Type: \(mimeType)\r\n")
        fieldData.append("\r\n")
        fieldData.append(data)
        fieldData.append("\r\n")

        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(authorizationValue, forHTTPHeaderField: authorizationHeaderField)
        request.setValue(version, forHTTPHeaderField: versionHeaderField)
        request.setValue(clientDevice, forHTTPHeaderField: deviceHeaderField)
        
        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }
}

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}

