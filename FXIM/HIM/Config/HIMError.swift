//
//  HIMError.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/23.
//

import Foundation

enum HIMError:Error {
    case coreDataSaveError(err:Error)
    case protobufError(err:Error)
    case updateError(err:Error)
    case protobufSerializedFail(err:Error)
}
extension HIMError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .coreDataSaveError(let err):
            return "coreDataSave错误,err =\(err.localizedDescription)"
        case .protobufError(let err):
            return "pb转data错误,err =\(err.localizedDescription)"
        case .updateError(let err):
            return "update message 错误,err=\(err.localizedDescription)"
        case .protobufSerializedFail(let err):
            return "protobuf Serialized 错误,err=\(err.localizedDescription)"
        }
    }
}
