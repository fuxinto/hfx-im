//
//  HIMTransform.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/5/6.
//

import Foundation

extension Pb_Message{
    func tranMsg() -> HIMMessage {
        let msg = HIMMessage()
        msg.timestamp = timestamp
        msg.content = content
        msg.msgUid = msgUid
        msg.conversationId = targetID
        msg.msgId = msgID
        msg.type = Int32(type.rawValue)
        msg.nickName = nickName
        msg.faceUrl = faceURL
        msg.status = Int32(status.rawValue)
        msg.senderId = senderID
        msg.targetId = targetID
        msg.cloudCustomData = cloudCustomData
        return msg
    }
}
