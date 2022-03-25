//
//  FXAttributedStrE.swift
//  医药项目
//
//  Created by fuxinto on 2019/12/30.
//  Copyright © 2019 fuxinto. All rights reserved.
//

import Foundation
extension FXNamespaceWrapper where Base : NSMutableAttributedString{
    static func addAttributes(text:String,rangeTexts:[String],_ attrs: [[NSAttributedString.Key : Any]]) -> NSMutableAttributedString {
        let attributeStr = NSMutableAttributedString.init(string: text)
        for (index,value) in rangeTexts.enumerated() {
            attributeStr.addAttributes(attrs[index], range: text.fx.getRange(rangeText: value))
        }
        return attributeStr
    }
    func addAttributes(text:String,rangeTexts:[String],_ attrs: [[NSAttributedString.Key : Any]]){
//        let attributeStr = NSMutableAttributedString.init(string: text)
        for (index,value) in rangeTexts.enumerated() {
            self.base.addAttributes(attrs[index], range: text.fx.getRange(rangeText: value))
        }
       
    }
    
}

