//
//  FXDateExtension.swift
//  FXGeneralSwift
//
//  Created by fuxinto on 2019/10/9.
//  Copyright © 2019 fuxinto. All rights reserved.
//

import Foundation

enum FXDateType:String {
    case YMD = "YYYY-MM-dd"
    case Hms = "HH:mm:ss"
    case YMDHm = "YYYY-MM-dd HH:mm"
    case YMDHms = "YYYY-MM-dd HH:mm:ss"
    
}



extension FXNamespaceWrapper where Base == Date {
    
    
    //获取秒时间戳
    static func getTimestamp() -> Int64 {
        let time = Int64(Date().timeIntervalSince1970)
        return time
    }
    //获取毫秒时间戳
    static func getMilliStamp() -> Int64 {
        let time = Int64(Date().timeIntervalSince1970*1000)
        return time
    }
  
    //获取当前时间字符串
    static func getCurrentDate(dateType:FXDateType) -> String{
        let now = Date()
        return now.fx.getFormatDateString(dateFormat: dateType.rawValue)
    }
    
    static func getCurrentDate(dateFormat:String) -> String{
        let now = Date()
        return now.fx.getFormatDateString(dateFormat: dateFormat)
    }
    
    func messageString() -> String {
        let calendar = Calendar.current
        let coms:Set<Calendar.Component> = [Calendar.Component.day,Calendar.Component.month,Calendar.Component.year]
        
        let myCmps = calendar.dateComponents(coms, from: self.base)
        let nowCmps = calendar.dateComponents(coms, from: Date.init())
        if myCmps.year != nowCmps.year {
           return base.fx.getFormatDateString(dateType: .YMD)
        }
        guard let nowDay = nowCmps.day,let myDay = myCmps.day else {
            FXLog("时间日历失败")
            return "时间日历序列化失败"
        }
        if myDay == nowDay {
            return base.fx.getFormatDateString(dateFormat: "HH:mm")
        }
        
        if nowDay - myDay == 1 {
            return "昨天 \(base.fx.getFormatDateString(dateFormat: "hh:mm"))"
        }
        if nowDay - myDay <= 7 {
            return base.fx.getFormatDateString(dateFormat: "EEEE")
        }
       return base.fx.getFormatDateString(dateType: .YMD)
    }
    
    func getFormatDateString(dateType:FXDateType) -> String {
        return getFormatDateString(dateFormat: dateType.rawValue)
    }
    func getFormatDateString(dateFormat:String) -> String {
        let dateFormatter = DateFormatter()
        //设置时间格式（这里的dateFormatter对象在上一段代码中创建）
        dateFormatter.dateFormat = dateFormat
        //DateFormatter对象的string方法执行转换(参数now为之前代码中所创建)
        return dateFormatter.string(from: self.base)
    }
    ///
    /// - Parameters:
    ///   - time: 时间戳（单位：s）
    ///   - format: 转换手的字符串格式
    /// - Returns: 转换后得到的字符串
    static func formatTimeStamp(time:Int ,dateType:FXDateType) -> String {
        return formatTimeStamp(time:time,dateFormat:dateType.rawValue)
    }
    
    ///
    /// - Parameters:
    ///   - time: 时间戳（单位：s）
    ///   - format: 转换手的字符串格式
    /// - Returns: 转换后得到的字符串
    static func formatTimeStamp(time:Int ,dateFormat:String) -> String {
        let timeInterval = TimeInterval.init(time)
        let date = Date.init(timeIntervalSince1970: timeInterval)
        return date.fx.getFormatDateString(dateFormat: dateFormat)
    }
    
    //时间显示内容
    static func getDateDisplay(timeStamp:Int,isMillisecond:Bool) -> String{
        let timeInterval = TimeInterval.init(timeStamp)
        let seconds = isMillisecond ? timeInterval/1000.0 : timeInterval
        let date = Date.init(timeIntervalSince1970: seconds)
        
        //日历
        var calendar = Calendar.current
        calendar.firstWeekday = 2 //一周的起始天数为星期一，设置为1起始天数为星期天
        let newDate = Date.init()
        let nowCmps = calendar.dateComponents([.year,.day,.month,.weekday], from: newDate)
        let myCmps = calendar.dateComponents([.year,.day,.month,.weekday], from: date)
        
        var dateFormat = "YYYY-MM-dd HH:mm"
        //是否为同一年
        if nowCmps.year != myCmps.year {
            dateFormat = "YYYY-MM-dd HH:mm"
        }else{
            //同一年
            if nowCmps.day == myCmps.day {
                //同一天
                dateFormat = "aahh:mm"
            }else if (nowCmps.day!-myCmps.day!) == 1 {
                //昨天
                dateFormat = "昨天 aahh:mm"
            }else {
                if myCmps.weekday == nowCmps.weekday  {
                    //同一周
                    switch myCmps.weekday {
                    case 1:
                        dateFormat = "星期日 aahh:mm"
                    case 2:
                        dateFormat = "星期一 aahh:mm"
                    case 3:
                        dateFormat = "星期二 aahh:mm"
                    case 4:
                        dateFormat = "星期三 aahh:mm"
                    case 5:
                        dateFormat = "星期四 aahh:mm"
                    case 6:
                        dateFormat = "星期五 aahh:mm"
                    case 7:
                        dateFormat = "星期六 aahh:mm"
                    default:
                        break
                    }
                }else{
                    dateFormat = "MM-dd HH:mm"
                }
            }
        }
        //创建一个DateFormatter来作为转换的桥梁
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "上午"
        dateFormatter.pmSymbol = "下午"
        dateFormatter.dateFormat = dateFormat
       return dateFormatter.string(from: date)
    }
}
