//
//  FXSotryboardExtension.swift
//  FXSwiftTest
//
//  Created by fuxinto on 2019/2/25.
//  Copyright © 2019 fuxinto. All rights reserved.
//

import UIKit

extension FXNamespaceWrapper where Base : UIWindow {
    static func keyWindow () -> UIWindow {
        if #available(iOS 13.0, *) {
            //系统版本高于
            //系统版本高于
            for window in UIApplication.shared.windows {
                if window.isKeyWindow {
                    return window
                }
            }
        } else {
            //系统版本低于
            return UIApplication.shared.keyWindow!
        }
        return UIWindow()
    }

}

