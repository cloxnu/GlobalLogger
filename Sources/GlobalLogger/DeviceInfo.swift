//
//  DeviceInfo.swift
//  GlobalLogger
//
//  Created by Sidney Liu on 9/23/24.
//

import UIKit

enum DeviceInfo {
    
    @MainActor static var name: String { UIDevice.current.name }
    @MainActor static var systemName: String { UIDevice.current.systemName }
    @MainActor static var systemVersion: String { UIDevice.current.systemVersion }
    @MainActor static var model: String { UIDevice.current.model }
    
    static var appVersion: String { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String }
    static var appBuildVersion: String { Bundle.main.infoDictionary?["CFBundleVersion"] as! String }
    
    private static func deviceModelIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    @MainActor
    static var description: String {
        """
----------------
Name: \(name)
System: \(systemName) \(systemVersion)
Model: \(deviceModelIdentifier())
App Version: \(appVersion) (\(appBuildVersion))
Date: \(Date())
Locale: \(Locale.current.identifier)
----------------
"""
    }
}
