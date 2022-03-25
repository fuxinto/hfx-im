//
//  FXStringExtension.swift
//  FXSwiftDemo
//
//  Created by fuxinto on 2019/4/17.
//  Copyright © 2019 fuxinto. All rights reserved.
//

import UIKit
import CryptoSwift

import SWCompression
import SwiftyRSA


enum FXURLStrType {
    case image
    case gif
    case video
}
extension FXNamespaceWrapper where Base == String {
    
    
    func localized() -> String {
        return NSLocalizedString(self.base, comment: self.base)
    }
    
    func tel(){
        
        if let url = NSURL.init(string: String(format: "tel://%@", base)) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    func StringToFloat()->(CGFloat){
        
        var cgFloat:CGFloat = 0
        
        
        if let doubleValue = Double(base)
        {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    // JSONString转换为字典
    
    func mapDictionary() -> [String:String]?{
        
        let jsonData:Data = base.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as? [String : String]
        }
        return nil
        
        
    }
    
    
    func getRange(rangeText:String) -> NSRange {
        guard self.contains(find: rangeText) else {
            return NSRange()
        }
        let range: Range = self.base.range(of:rangeText)!
        let location = self.base.distance(from: self.base.startIndex, to:range.lowerBound)
        return NSRange(location: location, length: rangeText.count)
    }
    //是否包含
    func contains(find: String) -> Bool{
        return self.base.range(of: find) != nil
    }
    //是否包含不区分大小写
    func containsIgnoringCase(find: String) -> Bool{
        return self.base.range(of: find, options: .caseInsensitive) != nil
    }
    func getWidth(height : CGFloat,font:UIFont) -> CGFloat {
        self.getSize(width: CGFloat(MAXFLOAT), height: height, font: font).width
    }
    func getHeight(width : CGFloat,font:UIFont) -> CGFloat {
        return self.getSize(width: width, height: CGFloat(MAXFLOAT), font: font).height
    }
    
    func getSize(width: CGFloat,height : CGFloat,font:UIFont) -> CGSize {
        return getSize(width: width, height: height, attributes: [NSAttributedString.Key.font:font])
    }
    func getSize(width: CGFloat,height : CGFloat,attributes:[NSAttributedString.Key:Any]) -> CGSize {
        self.base.boundingRect(with: CGSize(width: width, height: height), options:[.usesLineFragmentOrigin,.usesFontLeading], attributes: attributes, context: nil).size
    }
    func getSize(font:UIFont) -> CGSize {
        return self.getSize(width: CGFloat(MAXFLOAT),height: CGFloat(MAXFLOAT),font: font)
        
    }
    // MARK: - Emoji表情
    //是否存在
    var containsEmoji: Bool {
        for scalar in base.unicodeScalars {
            switch scalar.value {
            case
                0x00A0...0x00AF,
                0x2030...0x204F,
                0x2120...0x213F,
                0x2190...0x21AF,
                0x2310...0x329F,
                0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }

    //        //rsa解密
    //        func rsaDecrypt() -> String? {
    //            do {
    //                let privateKey = try PrivateKey(pemNamed: "private")
    //                let encrypted1 = try EncryptedMessage(base64Encoded: base)
    //                let clear1 = try encrypted1.decrypted(with: privateKey, padding: .PKCS1)
    //                return String(data: clear1.data, encoding: .utf8)
    //            } catch  {
    //                return nil
    //            }
    //        }
    var nilIfEmpty: String? {
        base.isEmpty ? nil : base
    }
  
    /// 生成随机字符串
    ///
    /// - Parameters:
    ///   - count: 生成字符串长度
    /// - Returns: String
    static func randomStr(_ count: Int) -> String {
        var str = String()
        for _ in 0..<count {
            let num =  arc4random_uniform(94)+33
            
            str.append(Character(UnicodeScalar(num)!))
        }
        return str
    }
    
    //手机号中间替换为*
    func mobileSecureText() -> String {
        var str = base
        //删除范围的字符串
        let  startIndex = str.index(str.startIndex, offsetBy: 3)
        let  endIndex = str.index(str.startIndex, offsetBy: 6)
        let  range = startIndex...endIndex
        str.replaceSubrange(range, with: "****")
        return str
    }
    
    /// 将中文字符串转换为拼音
    ///
    /// - Parameter hasBlank: 是否带空格（默认不带空格）
    func transformToPinyin(hasBlank: Bool = false) -> String {
        
        let stringRef = NSMutableString(string: self.base) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false) // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false) // 去掉音标
        let pinyin = stringRef as String
        return hasBlank ? pinyin : pinyin.replacingOccurrences(of: " ", with: "")
    }
    /// 获取中文首字母
    ///
    /// - Parameter lowercased: 是否小写（默认大写）
    func transformToPinyinHead(lowercased: Bool = false) -> String {
        let pinYin = self.transformToPinyin(hasBlank: true).capitalized // 字符串转换为首字母大写
        //截取第一位
        let firstString = pinYin.prefix(1)
        //        if lowercased {
        //            //小写
        //            //判断首字母是否为大写
        //            let regexA = "^[A-Z]$"
        //            let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        //            return predA.evaluate(with: firstString) ? String(firstString) : "#"
        //        }else{
        //            //大写
        //            //判断首字母是否为大写
        //            let regexA = "^[A-Z]$"
        //            let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        //            return predA.evaluate(with: firstString) ? String(firstString) : "#"
        //        }
        return lowercased ? firstString.lowercased() : String(firstString)
    }
    
    //MARK: - 正则
    
    /// 匹配
    ///
    /// - Parameter rules: 规则
    /// - Returns: 是否匹配
    func isMatch(_ rules: String ) -> Bool {
        let rules = NSPredicate(format: "SELF MATCHES %@", rules)
        let isMatch: Bool = rules.evaluate(with: self.base)
        return isMatch
    }
    
    /// 正则匹配手机号
    var isMobile: Bool {
        return isMatch("^1[0-9]{10}$")
    }
    /// 正则匹配用户身份证号15或18位
    var isUserIdCard: Bool {
        return isMatch("(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)")
    }
    
    /// 正则匹配用户密码6-18位数字和字母组合
    var isPassword: Bool {
        return isMatch("^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,}")
    }
    
    func imageUrlEncoding() -> String{
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        return self.base.addingPercentEncoding(withAllowedCharacters: charSet)!
    }
    func adding(numStr:String) -> String {
        let handler = NSDecimalNumberHandler.init(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        let number1 = NSDecimalNumber.init(string: self.base)
        let number2 = NSDecimalNumber.init(string: numStr)
        return String(format: "%@", number1.adding(number2, withBehavior: handler))
    }
    func multiplying(by numStr:String) -> String {
        let handler = NSDecimalNumberHandler.init(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        let number1 = NSDecimalNumber.init(string: self.base)
        let number2 = NSDecimalNumber.init(string: numStr)
        return String(format: "%@", number1.multiplying(by:number2, withBehavior: handler))
    }
}
