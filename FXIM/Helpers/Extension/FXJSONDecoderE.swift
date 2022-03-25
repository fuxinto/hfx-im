//
//  FXJSONDecoderE.swift
//  FXSwift
//
//  Created by 王聪 on 2020/11/19.
//

import Foundation

extension FXNamespaceWrapper where Base : JSONDecoder{
//    static func decode<T: Codable>(_ type: T.Type,from data: Data)  -> T? {
//        do {
//            let model = try JSONDecoder().decode(type, from: data)
//            return model;
//        } catch (let err) {
//            FXLog(err)
//            return nil
//        }
//    }
    
    static func decode<T: Codable>(_ type: T.Type,from data: Data)throws  -> T {
       return try JSONDecoder().decode(type, from: data)
    }
}
