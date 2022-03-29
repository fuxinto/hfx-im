//
//  HIMMessage.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import Foundation

extension HIMMessage{
    func tranPbMsg()throws -> Data{
        var pb = Pb_Message.init()
        pb.content = content!
        pb.type = Pb_ElemType.init(rawValue: Int(msgType))!
        pb.messageID = msgId!
        if let send = sendUser {
            var user = Pb_UserInfo.init()
            user.userID = send.userId!
            pb.sender = user
        }
        pb.targetID = targetId!
        pb.sessionType = Pb_SessionType.init(rawValue: Int(sessionType))!
        do {
            return try pb.serializedData()
        } catch let err {
            throw HIMError.protobufError(err: err)
        }
        
    }
    
    static func update(msgId:String,date:Date,msgUid:String)throws {
        let fetchRequest = Self.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "msgId= '%@'", msgId)
        
        //查询操作
            do {
                let fetchedObjects = try PersistenceController.shared.privateContext.fetch(fetchRequest)
                //遍历查询的结果
                for msg in fetchedObjects{
                    //修改密码
                    msg.msgUid = msgUid
                    msg.time = date
                    msg.status = Int16(Pb_MessageStatus.init_.rawValue)
                    //重新保存
                    try PersistenceController.shared.privateContext.save()
                }
            }
            catch (let err){
                FXLog("消息保存失败，err=\(err.localizedDescription)")
                throw HIMError.updateError(err: err)
            }
        
    }
}
