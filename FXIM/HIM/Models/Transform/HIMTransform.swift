//
//  HIMTransform.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/5/6.
//

import Foundation

extension Pb_Message{
    func tranMsg() -> HIMMessage {
        let msg = HIMMessage(context: PersistenceController.shared.privateContext)
        msg.timestamp = timestamp
        msg.content = content
        msg.msgUid = msgUid
        msg.sessionId = sender == HIMSDK.shared.loginManager.userId ? targetID : targetID
        msg.msgId = msgID
        msg.type = Int16(type.rawValue)
        msg.nickName = nickName
        msg.faceURL = faceURL
        msg.status = Int16(status.rawValue)
        msg.sendId = sender
        msg.targetId = targetID
        msg.cloudCustomData = cloudCustomData
        return msg
    }
}
