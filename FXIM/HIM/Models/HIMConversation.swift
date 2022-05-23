//
//  HIMSession.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import Foundation
import WCDBSwift
class HIMConversation: TableCodable {
    var conversationId: String = ""
    var timestamp: Int64? = nil
    var type: Int32 = 0
    var unreadCount:Int32 = 0
    var lastMessage:HIMMessage?
    enum CodingKeys: String, CodingTableKey {
        typealias Root = HIMConversation
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case conversationId = "conversation_id"
        case timestamp
        case type
        case unreadCount = "unread_count"
    }
    
    static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
        return [
            .conversationId: ColumnConstraintBinding(isPrimary: true),
            .type: ColumnConstraintBinding(isNotNull: true)
        ]
    }
}

extension HIMConversation{
//    var showName:String{
//        get{
//            return "测试昵称"
//        }
//    }

    
//    static func getSession(msg:HIMMessage) -> HIMSession? {
//        //建立一个请求
//        let request = HIMSession.fetchRequest()
//        request.fetchLimit = 1
//        request.fetchOffset = 0
//        request.predicate = NSPredicate.init(format: "sessionId = %@", msg.sessionId!)
//        do {
//            let result =  try PersistenceController.shared.privateContext.fetch(request)
//            if let session = result.first {
//                session.lastMessage = msg
//                session.timestamp = msg.timestamp
//                session.unreadCount += 1
//                return session
//            }else{
//                return msg.tranSession()
//            }
//        } catch let error {
//            FXLog("getLast(sessionId:String)(),error:\(error.localizedDescription)")
//            return nil
//        }
//    }
}
