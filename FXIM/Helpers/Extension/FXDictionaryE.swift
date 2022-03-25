//
//  FXDictionaryE.swift
//  到家客商家端
//
//  Created by 黄福鑫 on 2020/11/24.
//

import Foundation


extension Dictionary {
    func fx_toJsonString() -> String? {
        
        guard JSONSerialization.isValidJSONObject(self) else {
            FXLog("无法解析出jsonstring")
            return nil
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            let str = String.init(data: data, encoding: .utf8)
//            let str = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return str ?? nil
        } catch    {
            FXLog("数组转json失败")
        }
        return nil
        
        
    }
    
        
  
}
