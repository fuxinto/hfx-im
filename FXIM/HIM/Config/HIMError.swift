//
//  HIMError.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/23.
//

import Foundation

enum HIMError:Error {
    case protobufSerializedFail //proto错误
    case other//其它错误
   
}

extension HIMError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .protobufSerializedFail:
            return "protobuf错误"
        case .other:
            return "其它错误"
       
        }
    }
}
