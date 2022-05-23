//
//  HIMMessage.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import Foundation
import WCDBSwift
class HIMMessage:TableCodable{
    var msgId:String = ""
    var msgUid:String? = nil
    var status:Int32 = 0
    var type:Int32 = 0
    var targetId:String = ""
    var senderId:String = ""
    var conversationId:String = ""
    var faceUrl:String? = nil
    var nickName:String? = nil
    var content:String? = nil
    var cloudCustomData:Data? = nil
    var timestamp:Int64 = Date.fx.getMilliStamp()
    static let tableName = "message"
    enum CodingKeys: String, CodingTableKey {
        typealias Root = HIMMessage
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case msgId = "msg_id"
        case msgUid = "msg_uid"
        case status
        case type
        case senderId = "sender_id"
        case targetId = "target_id"
        case conversationId = "conversation_id"
        case content
        case cloudCustomData = "cloud_custom_data"
        case timestamp
        
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                msgId: ColumnConstraintBinding(isPrimary: true),
                type: ColumnConstraintBinding(isNotNull: true),
                senderId: ColumnConstraintBinding(isNotNull: true),
                conversationId: ColumnConstraintBinding(isNotNull: true)
            ]
        }
    }
}

extension HIMMessage{
    func tranPbMsg() -> Data?{
        var pb = Pb_Message.init()
        if let data = content {
            pb.content = data
        }
        if let str = faceUrl {
            pb.faceURL = str
        }
        pb.type = Pb_ElemType.init(rawValue: Int(type))!
        pb.msgID = msgId
        pb.senderID = senderId
        pb.nickName = nickName!
        
        pb.status = Pb_MessageStatus.init(rawValue: Int(status))!
        pb.conversationID = conversationId
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
    
    func getLastMsgTimestamp() -> Int64? {
        do {
            return try WCDBDataBase.share.db.getValue(on: HIMMessage.Properties.timestamp.max(), fromTable: HIMMessage.tableName).int64Value
        } catch  {
            FXLog("getLastMsgTimestamp错误;error:\(error.localizedDescription)")
            return nil
        }
    }
    
    func tranSession() -> HIMConversation{
        let session = HIMConversation()
        session.conversationId = conversationId
        session.timestamp = timestamp
        session.type = type
        session.unreadCount = 1
        session.lastMessage = self
        return session
    }
    
//    static func getLast(sessionId:String) -> HIMMessage? {
//        //建立一个请求
//        let request = HIMMessage.fetchRequest()
//        request.fetchLimit = 1
//        request.fetchOffset = 0
//        request.sortDescriptors = [NSSortDescriptor.init(key: "timestamp", ascending: false)]
//        request.predicate = NSPredicate.init(format: "sessionId = %@", sessionId)
//        do {
//            let msg =  try PersistenceController.shared.privateContext.fetch(request)
//            return msg.first
//        } catch let error {
//            FXLog("getLast(sessionId:String)(),error:\(error.localizedDescription)")
//            return nil
//        }
//    }
//
//    static func update(msgId:String,timestamp:Int64,msgUid:String)throws {
//        let fetchRequest = Self.fetchRequest()
//        fetchRequest.fetchLimit = 1
//        fetchRequest.predicate = NSPredicate(format: "msgId= '%@'", msgId)
//
//        //查询操作
//        do {
//            let fetchedObjects = try PersistenceController.shared.privateContext.fetch(fetchRequest)
//            //遍历查询的结果
//            for msg in fetchedObjects{
//                //修改密码
//                msg.msgUid = msgUid
//                msg.timestamp = timestamp
//                msg.status = Int16(Pb_MessageStatus.init_.rawValue)
//                //重新保存
//                try PersistenceController.shared.privateContext.save()
//            }
//        }
//        catch (let err){
//            FXLog("消息保存失败，err=\(err.localizedDescription)")
//            throw HIMError.updateError(err: err)
//        }
//
//    }
}
