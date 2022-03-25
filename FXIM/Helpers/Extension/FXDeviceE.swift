//
//  FXDeviceExtension.swift
//  FXGeneralSwift
//
//  Created by fuxinto on 2019/10/22.
//  Copyright © 2019 fuxinto. All rights reserved.
//


import UIKit
extension FXNamespaceWrapper where Base : UIDevice {
    //MARK: - 设备的具体型号

    //获取导航栏高度
    static var navigationBarHeight : CGFloat {
       
        return 44 + statusBarHeight

    }
    
    static var bottomSafaHeight :CGFloat{
        return UIWindow.fx.keyWindow().safeAreaInsets.bottom
    }
    
    static var isBigPhone :Bool{
        get{
           return UIScreen.main.bounds.size.width >= 375 &&  UIScreen.main.bounds.size.height >= 812
        }
    }
    
    //获取状态栏高度
    static  var statusBarHeight : CGFloat {
        return (UIWindow.fx.keyWindow().windowScene?.statusBarManager?.statusBarFrame.size.height)!
    }
    //获取tabBar高度
    static  var tabBarHeight : CGFloat {
        if UIScreen.main.bounds.size.width >= 375 &&  UIScreen.main.bounds.size.height >= 812 {
            return 83.0
        }
        return 49.0
    }
    
        static func modelName() ->String{

            var systemInfo = utsname()

            uname(&systemInfo)

            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }

            switch identifier {

            case"iPod5,1":                                return"iPod Touch 5"

            case"iPod7,1":                                return"iPod Touch 6"



            case "iPhone3,1", "iPhone3,2", "iPhone3,3":    return "iPhone4"

            case"iPhone4,1":                              return"iPhone4s"

            case"iPhone5,1","iPhone5,2":                  return"iPhone5"

            case "iPhone5,3", "iPhone5,4":                return "iPhone5c"

            case "iPhone6,1", "iPhone6,2":                return "iPhone5s"

            case"iPhone7,2":                              return"iPhone6"

            case"iPhone7,1":                              return"iPhone6 Plus"

            case"iPhone8,1":                              return"iPhone6s"

            case"iPhone8,2":                              return"iPhone6s Plus"

            case"iPhone8,4":                              return"iPhoneSE"

            case"iPhone9,1",  "iPhone9,3":                return"iPhone7"

            case "iPhone9,2",  "iPhone9,4":              return "iPhone7 Plus"

            case "iPhone10,1", "iPhone10,4":                return "iPhone8"

            case "iPhone10,5", "iPhone10,2":                return "iPhone8 Plus"

            case "iPhone10,3", "iPhone10,6":                return "iPhoneX"

            case"iPhone11,2":                              return"iPhoneXS"

            case"iPhone11,6":                              return"iPhoneXS_MAX"

            case"iPhone11,8":                              return"iPhoneXR"
            
            case"iPhone12,1":                                return"iPhone11"
            
            case"iPhone12,3":                              return"iPhone11_Pro"

            case"iPhone12,5":                              return"iPhone11_Pro_Max"

            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"

            case "iPad3,1", "iPad3,2", "iPad3,3":          return "iPad 3"

            case "iPad3,4", "iPad3,5", "iPad3,6":          return "iPad 4"

            case "iPad4,1", "iPad4,2", "iPad4,3":          return "iPad Air"

            case"iPad5,3","iPad5,4":                               return"iPad Air 2"

            case "iPad2,5", "iPad2,6", "iPad2,7":          return "iPad Mini"

            case "iPad4,4", "iPad4,5", "iPad4,6":          return "iPad Mini 2"

            case "iPad4,7", "iPad4,8", "iPad4,9":          return "iPad Mini 3"

            case"iPad5,1","iPad5,2":                       return"iPad Mini 4"

            case"iPad6,7","iPad6,8":                       return"iPad Pro"



           case"AppleTV5,3":                              return    "Apple TV"

            case"i386","x86_64":                          return    "Simulator"

            default:                                      return identifier

        }
    }
    
    // 获取缓存
    static func getCacheSize() -> String {
            let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
            let fileArr = FileManager.default.subpaths(atPath: cachePath!)
            var size = 0
            for file in fileArr! {
                let path = cachePath! + "/\(file)"
                let floder = try! FileManager.default.attributesOfItem(atPath: path)
                for (key, fileSize) in floder {
                    if key == FileAttributeKey.size {
                        size += (fileSize as AnyObject).integerValue
                    }
                }
            }
            let totalCache = Double(size) / 1000.00 / 1000.00
            return String(format: "%.2fM", totalCache)
        }
    //删除缓存
        static func clearCache() {
            let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
            let fileArr = FileManager.default.subpaths(atPath: cachePath!)
            for file in fileArr! {
                let path = cachePath! + "/\(file)"
                if FileManager.default.fileExists(atPath: path) {
                    do {
                        try FileManager.default.removeItem(atPath: path)
                    }catch {
                        
                    }
                }
            }
        }
}
