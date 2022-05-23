//
//  HIMMessagePushHandler.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/4/28.
//

import Foundation



class HIMMessagePullAckHandler: HIMBaseHandler<Pb_MessagePullAck> {
    
    override func bodyClass() -> Pb_MessagePullAck.Type {
        return Pb_MessagePullAck.self
    }
    
    override func receive(body:Pb_MessagePullAck) {
        FXLog("收到push消息\(body.msglist.count)条")
        if body.msglist.isEmpty {
            return
        }
        var conversationIds = [String]()

        for m in body.msglist {
         let  msg = m.tranMsg()
            
            if !conversationIds.contains(msg.conversationId) {
                conversationIds.append(msg.conversationId)
            }
        }
    }
    
    //心跳拉取消息
    func pullMsg() {
        var timestamp:Int64 = 0
        if let t = HIMMessageManager.getLastMsgTimestamp(){
            timestamp = t
        }
        var pull = Pb_MessagePullReq()
        pull.timestamp = timestamp
        if let heartbeatBody = HIMMessageGen.createPack(body: pull, type: .msgPullReq) {
            HIMSDK.shared.socketManager.push(body: heartbeatBody)
        }
    }
    

}
