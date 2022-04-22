//
//  DeviceHelper.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import UIKit

struct DeviceInfo: Codable {
    let appVersion: String
    let deviceBrand: String
    let deviceModel: String
    let osVersion: String
    let uniqueToken: String
}

class DeviceHelper {
    static func getDeviceInfo() -> DeviceInfo {
        let deviceBrand = "Apple"
        let deviceModel = UIDevice.current.modelName
        let osVersion = UIDevice.current.systemVersion
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let uniqueToken = UIDevice.current.identifierForVendor!.uuidString
       
        return DeviceInfo(appVersion: appVersion, deviceBrand: deviceBrand, deviceModel: deviceModel, osVersion: osVersion, uniqueToken: uniqueToken)
    }
}

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}


