//
//  HIMSessionPushHandler.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/4/28.
//

import Foundation
class HIMSessionPushHandler: HIMBaseHandler<Pb_MessagePush> {
 
    override func bodyClass() -> Pb_MessagePush.Type {
        return Pb_MessagePush.self
    }
    
    override func receive(body:Pb_MessagePush) {
        FXLog("收到push消息\(body.msglist.count)条")
        if body.msglist.isEmpty {
            return
        }
    }
    
    func pullSession() {
        var timestape:Int64 = 0
        if let t = HIMMessageManager.getLastMsgTimestamp() {
            timestape = t
        }
        
        
    }
    
}
