//
//  FXPropertyWrapper.swift
//  FXRecipes
//
//  Created by 黄福鑫 on 2021/11/16.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import UIKit


@propertyWrapper /// 先告诉编译器 下面这个UserDefault是一个属性包裹器
struct UserDefault<T> {
    ///这里的属性key 和 defaultValue 还有init方法都是实际业务中的业务代码
    ///我们不需要过多关注
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
///  wrappedValue是@propertyWrapper必须要实现的属性
/// 当操作我们要包裹的属性时  其具体set get方法实际上走的都是wrappedValue 的set get 方法。
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
