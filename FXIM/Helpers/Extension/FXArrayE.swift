//
//  FXArrayExtension.swift
//  FXGeneralSwift
//
//  Created by fuxinto on 2019/11/26.
//  Copyright © 2019 fuxinto. All rights reserved.
//

import Foundation
extension Array {
    
    func fx_toJson() -> String {
        guard JSONSerialization.isValidJSONObject(self) else {
            FXLog("无法解析出JSONString")
            return ""
        }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return ""
        }
        
        return String(data: data, encoding: .utf8) ?? ""
    }

    func fx_toMtbAry() -> NSMutableArray {
        let MtbAry: NSMutableArray = []
            for item in self {
                MtbAry.add(item)
            }
        return MtbAry
    }
}


extension FXNamespaceWrapper where Base == Array<Any>{
    
    func toJsonString() -> String? {
        guard JSONSerialization.isValidJSONObject(self.base) else {
            FXLog("无法解析出jsonstring")
            return nil
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: self.base, options: [])
            let str = String.init(data: data, encoding: .utf8)
            return str ?? nil
        } catch  {
            FXLog("数组转json失败")
        }
        return nil
    }
    /// 数组内中文按拼音字母排序
    ///
    /// - Parameter ascending: 是否升序（默认升序）
    func sortedByPinyin(ascending: Bool = true) -> Array<String>? {
        if self.base is Array<String> {
            return (self.base as! Array<String>).sorted { (value1, value2) -> Bool in
                let pinyin1 = value1.fx.transformToPinyinHead()
                let pinyin2 = value2.fx.transformToPinyinHead()
                return pinyin1.compare(pinyin2) == (ascending ? .orderedAscending : .orderedDescending)
            }
        }
        return nil
    }
    

}
