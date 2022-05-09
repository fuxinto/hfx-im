//
//  HIMMessage.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import Foundation

extension HIMMessage{
    func tranPbMsg() -> Data?{
        var pb = Pb_Message.init()
        pb.content = content!
        pb.type = Pb_ElemType.init(rawValue: Int(type))!
        pb.msgID = msgId!
        pb.sender = sendId!
        pb.nickName = nickName!
        pb.faceURL = faceURL!
        pb.status = Pb_MessageStatus.init(rawValue: Int(status))!
        pb.targetID = targetId!
        if let data = cloudCustomData {
            pb.cloudCustomData = data
        }
        do {
            return try pb.serializedData()
        } catch let err {
            FXLog("tranPbMsg()；error\(err.localizedDescription)")
            return nil
        }
    }
    
    func tranSession() -> HIMSession{
        let session = HIMSession(context:PersistenceController.shared.privateContext)
        session.sessionId = sessionId
        session.timestamp = timestamp
        session.type = type
        session.lastMessage = self
        return session
    }
    
    static func getLast(sessionId:String) -> HIMMessage? {
        //建立一个请求
        let request = HIMMessage.fetchRequest()
        request.fetchLimit = 1
        request.fetchOffset = 0
        request.sortDescriptors = [NSSortDescriptor.init(key: "timestamp", ascending: false)]
        request.predicate = NSPredicate.init(format: "sessionId = %@", sessionId)
        do {
            let msg =  try PersistenceController.shared.privateContext.fetch(request)
            return msg.first
        } catch let error {
            FXLog("getLast(sessionId:String)(),error:\(error.localizedDescription)")
            return nil
        }
    }
    
    static func update(msgId:String,timestamp:Int64,msgUid:String)throws {
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
                msg.timestamp = timestamp
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
