//
//  HIMSession.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import Foundation

extension HIMSession{
    var showName:String{
        get{
            return "测试昵称"
        }
    }

    
    static func getSession(msg:HIMMessage) -> HIMSession? {
        //建立一个请求
        let request = HIMSession.fetchRequest()
        request.fetchLimit = 1
        request.fetchOffset = 0
        request.predicate = NSPredicate.init(format: "sessionId = %@", msg.sessionId!)
        do {
            let result =  try PersistenceController.shared.privateContext.fetch(request)
            if let session = result.first {
                session.lastMessage = msg
                session.timestamp = msg.timestamp
                return session
            }else{
                return msg.tranSession()
            }
        } catch let error {
            FXLog("getLast(sessionId:String)(),error:\(error.localizedDescription)")
            return nil
        }
    }
}
