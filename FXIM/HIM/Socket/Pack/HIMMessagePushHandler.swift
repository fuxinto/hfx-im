//
//  HIMMessagePushHandler.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/4/28.
//

import Foundation



class HIMMessagePushHandler: HIMBaseHandler<Pb_MessagePush> {
    
    override func bodyClass() -> Pb_MessagePush.Type {
        return Pb_MessagePush.self
    }
    
    override func receive(body:Pb_MessagePush) {
        FXLog("收到push消息\(body.msglist.count)条")
        if body.msglist.isEmpty {
            return
        }
        for m in body.msglist {
         let  msg = m.tranMsg()
            let session = HIMSession.getSession(msg: msg)
            
        }
        PersistenceController.shared.saveContext()
        
    }
    
    //心跳拉取消息
    func pullMsg() {
        var timestamp:Int64 = 0
        
        if let t = HIMMessageManager.getLastMsgTimestamp(){
            timestamp = t
        }
        var pull = Pb_MessagePull()
        pull.timestamp = timestamp
        pull.ascending = true
        if let heartbeatBody = HIMMessageGen.createPack(body: pull, type: .msgPull) {
            HIMSDK.shared.socketManager.push(body: heartbeatBody)
        }
    }
    

}
