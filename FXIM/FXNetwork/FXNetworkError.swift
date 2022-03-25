//
//  FXResponseError.swift
//  FXRecipes
//
//  Created by hfx on 2021/4/23.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import Foundation

enum FXNetworkError:Error {
    case decryption //解密错误
    case other//其它错误
    case responseError //返回错误
    case jsonParse//json解析错误
}

extension FXNetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decryption:
            return "解密错误"
        case .other:
            return "其它错误"
        case .responseError:
            return "responseCode错误"
        case .jsonParse:
            return "json解析model错误"
        }
    }
}
