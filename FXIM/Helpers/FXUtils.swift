//
//  FXUtils.swift
//  Hera
//
//  Created by fuxinto on 2020/7/20.
//  Copyright © 2020 黄福鑫. All rights reserved.
//

import UIKit




class FXUtils {
    
    
    static func exitAppAction (){
        UIView.animate(withDuration: 1.0, animations: {
            UIWindow.fx.keyWindow().alpha = 0
            UIWindow.fx.keyWindow().transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }) { (_) in
            exit(1)
        }
    }
    
    
}
