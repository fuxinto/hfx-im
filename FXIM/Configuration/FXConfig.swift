//
//  FXConfig.swift
//  FXSwift
//
//  Created by 王聪 on 2020/11/18.
//

import Foundation
import UIKit


func FXMain(_ handler:@escaping()->Void) {
    if !Thread.isMainThread {
        DispatchQueue.main.async {
            handler()
        }
    }else{
        handler()
    }
}


func FXLog<T>(_ message :T ,file:String = #file,method: String = #function, line: Int = #line) {
    #if DEBUG
    print("[\((file as NSString).lastPathComponent).\(line) \(Date.fx.getCurrentDate(dateType: .Hms))]:\n\(message)")
    #else

    #endif
}

public func FXPrint<T>(_ message: T, file:String = #file, funcName:String = #function, lineNum:Int = #line) {
    #if DEBUG
//    let fileName = (file as NSString).lastPathComponent
    print("\(message)")
    #else

    #endif
}

typealias FXStringHandler = (String) -> Void
typealias FXIntHandler = (Int) -> Void
typealias FXVoidHandler = () -> Void
typealias FXBoolHandler = (Bool) -> Void
typealias FXFloatHandler = (CGFloat) -> Void



public enum FXResult {
    /// A success, storing a `Success` value.
    case success
    /// A failure, storing a `Failure` value.
    case failure
}
