//
//  FXDataE.swift
//  FXRecipes
//
//  Created by hfx on 2021/4/23.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import Foundation
import CryptoSwift
extension FXNamespaceWrapper where Base == Data {
    //解密
    func aesDecrypt(key:String,iv:String) -> Data? {
        do {
            // aes解密
            let aes = try AES(key: key, iv: iv, padding: .pkcs7).decrypt([UInt8](base))
            //[UInt8]转string
            return Data.init(bytes: aes, count: aes.count)
        } catch  {
            FXLog("aes解密失败")
            return nil
        }
    }
    //加密
    func aesEncrypt(key: String,iv:String) -> Data {
        do {
            //aes加密
            let encoded = try AES(key: key, iv: iv, padding: .pkcs7).encrypt([UInt8](base))
            //加密数据已base64输出a
            //[UInt8]转data
            let data = Data.init(bytes: encoded, count: encoded.count)
            //database64编码
            return data
//            return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        } catch  {
            FXLog("aes加密失败")
            return Data()
        }
    }
}



