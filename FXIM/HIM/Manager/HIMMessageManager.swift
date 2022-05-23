//
//  FXMessageManager.swift
//  FXRecipes
//
//  Created by hfx on 2021/8/31.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import Foundation

enum HIMMsgStatus:Int16 {
    ///消息创建
    case msgInit = 0
    /// 消息发送中
    case sending = 1
    /// 消息发送成功
    case sendSucc  = 2
    /// 消息发送失败
    case sendFail  = 3
    /// 消息被删除
    case hasDeleted  = 4
    /// 导入到本地的消息
    case localImported  = 5
    /// 被撤销的消息
    case localRevoked  = 6
}


class HIMMsgHandler{
    let succ:HIMSucc
    let fail:HIMFail
    init(succ:@escaping HIMSucc,fail:@escaping HIMFail) {
        self.succ = succ
        self.fail = fail
    }
}

class HIMMessageManager: HIMBaseHandler<Pb_Message> {
    var MsgsMonitor = [String:HIMMsgHandler]()
    
    static func getLastMsgTimestamp() -> Int64? {
        return 0
    }
    
    
    func createMessage(content:String,to userId:String) -> HIMMessage? {
        let msg = HIMMessage()
        msg.content = content
        msg.senderId = HIMSDK.shared.loginManager.userId
        msg.conversationId = userId
        msg.targetId = userId
        msg.msgId = UUID().uuidString
        msg.type = Int32(Pb_ElemType.text.rawValue)
       return msg
    }
    
    func sendC2CTextMessage(text:String,to userId:String,succ:@escaping HIMSucc,fail:@escaping HIMFail) {
        guard  let msg = createMessage(content: text, to: userId) else { return fail(404,"本地消息创建失败") }

        let hander = HIMMsgHandler.init(succ: succ, fail: fail)
        let key = msg.msgId
        MsgsMonitor[key] = hander
        guard let data =   msg.tranPbMsg() else {
            //init错误
            fail(4000,"消息初始化失败")
            return
        }
        
        HIMSDK.shared.socketManager.push(body:data)
          //异步延时检测是否发送成功
          DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
              guard let msgHandler = self.MsgsMonitor[key] else{
                  return
              }
              msgHandler.fail(20003,"消息发送失败")
          }
      
         //更新会话列表
//        FXIMSDK.shared.conversationManager.received(msg: msg)
        //        NotificationCenter.default.post(name: FXIMNotificationMessageListener, object: msg, userInfo: nil)
    }
    //
    //
        override func bodyClass() -> Pb_Message.Type {
            return Pb_Message.self
        }
    //
        /// 收到socket消息投递
        /// - Parameter body: protobuf消息体
        override func receive(body:Pb_Message) {
//            let msg = FXIMMessage.insert(body: body)
//            //更新会话表
//            FXIMSDK.shared.conversationManager.received(msg: msg)
//            NotificationCenter.default.post(name: FXIMNotificationMessageListener, object: msg, userInfo: nil)
        }
    //    /**
    //     *  获取单聊历史消息
    //     *
    //     *  @param count 拉取消息的个数，不宜太多，会影响消息拉取的速度，这里建议一次拉取 20 个
    //     *  @param lastMsg 获取消息的起始消息，如果传 nil，起始消息为会话的最新消息
    //     *
    //     *  @note 如果 SDK 检测到没有网络，默认会直接返回本地数据
    //     */
    //
    //    func getC2CHistoryMessageList(talker:Int64,count:Int,lastMsg:FXIMMessage?,succ:@escaping FXIMMessageResultSucc,fail:@escaping FXIMFail) {
    //        FXIMMessage.getC2CHistoryMessageList(talker: talker, count: count, lastMsg: lastMsg, succ: succ, fail: fail)
    //    }
    //
}

