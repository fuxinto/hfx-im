//
//  FXWrapper.swift
//  医药项目
//
//  Created by fuxinto on 2019/12/18.
//  Copyright © 2019 fuxinto. All rights reserved.
//

import Foundation


public struct FXNamespaceWrapper<Base> {
    public var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

protocol FXNamespaceWrappable : AnyObject {
    associatedtype T
    var fx: T { get }
    static var fx: T.Type { get }
}


extension FXNamespaceWrappable {
    var fx: FXNamespaceWrapper<Self> {
        return FXNamespaceWrapper<Self>(self)
    }

    static var fx: FXNamespaceWrapper<Self>.Type {
        return FXNamespaceWrapper.self
    }
}

protocol FXCompatibleValue {
    associatedtype T
    var fx: T { get }
    static var fx: T.Type { get }
}

extension FXCompatibleValue {
    var fx: FXNamespaceWrapper<Self> {
        return FXNamespaceWrapper<Self>(self)
    }

    static var fx: FXNamespaceWrapper<Self>.Type {
        return FXNamespaceWrapper.self
    }
}

//如果扩展的是值类型，比如 String，Date 等，就必须使用 ==，如果扩展的是类，则两者都可以使用，区别是如果使用 == 来约束，则扩展方法只对本类生效，子类无法使用。如果想要在子类也使用扩展方法，则使用 : 来约束。

//对类型扩展实现 NamespaceWrappable 协议，只需要写一次。如果对 UIView 已经写了 NamespaceWrappable 协议实现，则 UILabel 不需要再写。实际上写了之后，编译会报错。

//extension UIApplication : FXNamespaceWrappable {}
//extension UIView : FXNamespaceWrappable{}
extension NSObject : FXNamespaceWrappable {}
extension JSONDecoder : FXNamespaceWrappable {}
extension JSONEncoder : FXNamespaceWrappable {}
//extension UIImage : FXNamespaceWrappable{}
//
//extension UIViewController : FXNamespaceWrappable{}

//extension CGSize : FXCompatibleValue {
//}



extension String : FXCompatibleValue {
}

extension Date : FXCompatibleValue {
    
}
extension Data : FXCompatibleValue {
    
}

extension Array : FXCompatibleValue {
    
}


extension Int : FXCompatibleValue {
}



extension FXNamespaceWrapper where Base == Int?{
    func string() -> String {
        guard let num = base else {
            return ""
        }
        return String(num)
    }
}

