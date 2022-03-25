//
//  HUIMessage.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/3.
//

import Foundation
class HUIUser {
    var name:String
    var avatar:String
    var userId:String
    init(name:String,avatar:String,userId:String){
        self.userId = userId
        self.name = name
        self.avatar = avatar
    }
}
class HUITextMessage{
    var content:String
    init(content:String){
        self.content = content
    }
}
class HUIImageMessage{
    var url:String
    init(url:String){
        self.url = url
    }
}


class HUIMessage{
    /// 消息id
    var messageId:String!
//    var session:String!//为消息发送到对话的 Id 。当发送的是点对点消息时，此 Id 为接受者 Id；当发送的是群或聊天室消息时，此 Id 为群或聊天室 Id 。
    /// 消息发送者
    var senderId: String!
    //消息目标的id
    var targetId:String!
    /// 消息发送者
    var sender:HUIUser!
    /// 消息时间
    let timestamp = Date.fx.getMilliStamp()
    /// 消息内容
    var textMessage:HUITextMessage?
    var elemType:Pb_ElemType!
    var imageMessage:HUIImageMessage?
    
}
