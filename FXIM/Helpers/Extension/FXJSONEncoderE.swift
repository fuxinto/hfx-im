//
//  JSONEncoderE.swift
//  FXSwift
//
//  Created by 王聪 on 2020/11/19.
//

import Foundation
extension FXNamespaceWrapper where Base : JSONEncoder{
    
    static func encode<T: Codable>(json model: T?) -> String? {
        do {
           let jsonData = try JSONEncoder().encode(model)
           let jsonString = String(decoding: jsonData, as: UTF8.self)
           FXLog(jsonString)
            return jsonString
        }catch{
            FXLog(error.localizedDescription)
            return nil
        }
    }
    
    static func encode<T: Codable>(_ models: [T]) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? JSONEncoder().encode(models) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8) ?? nil
    }

    
    static func encode<T: Codable>(_ model: T) -> [String:Any]? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? JSONEncoder().encode(model) else {
            return nil
        }
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:Any] else {
            return nil
        }
        return dict
    }
}

