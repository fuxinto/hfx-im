//
//  HIMSessionPushHandler.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/4/28.
//

import Foundation


class HIMSessionPushHandler: HIMBaseHandler<Pb_SessionPush> {
 

    override func bodyClass() -> Pb_SessionPush.Type {
        return Pb_SessionPush.self
    }
    
    override func receive(body:Pb_SessionPush) {
        FXLog("收到push消息\(body.sessionList.count)条")
        if body.sessionList.isEmpty {
            return
        }
        var sessionList = [HIMSession]()
        for s in body.sessionList {
            let session = HIMSession(context: PersistenceController.shared.privateContext)
            session.timestamp = s.timestamp
            session.offlineMsg = s.isOfflineMsg
            session.pinned = s.isPinned
            session.sessionId = s.sessionID
            if !s.msglist.isEmpty {
                for m in s.msglist {
                  _ = m.tranMsg()
                }
                session.lastMessage = s.msglist.first!.tranMsg()
            }
            session.unreadCount = s.unreadCount
            sessionList.append(session)
        }
        PersistenceController.shared.saveContext()
        HIMSDK.shared.sessionManager.listener?.onSessionChanged(sessionList: sessionList)
    }
    
    func pullSession() {
        var timestape:Int64 = 0
        if let t = HIMMessageManager.getLastMsgTimestamp() {
            timestape = t
        }
        var pull =  Pb_SessionPull.init()
        pull.timestamp = timestape
        if let heartbeatBody = HIMMessageGen.createPack(body: pull, type: .sessionPull) {
            HIMSDK.shared.socketManager.push(body: heartbeatBody)
        }
    }
}
