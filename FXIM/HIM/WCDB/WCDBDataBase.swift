//
//  WCDBDataBase.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/5/17.
//

import Foundation
import WCDBSwift
class WCDBDataBase{
    let basePath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    var db: Database!
    static let share = WCDBDataBase.init()
    
    private init() {
        guard let userId = HIMSDK.shared.loginManager.userId else {
            FXLog("未获取到用户id")
            return  }
        db = Database(withPath: basePath + "/\(userId)/him.db")
    }
    
}

