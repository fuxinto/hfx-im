//
//  HUIMessage.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/3.
//

import Foundation
class HUIUser {
    var nickName:String
    var avatar:String
    var userId:String
    init(name:String,avatar:String,userId:String){
        self.userId = userId
        self.nickName = name
        self.avatar = avatar
    }
}

extension HUIMessage {
    static func test() -> HUIMessage{
        var msg = HUIMessage()
        let text = HUITextMessage.init(content: "cljslkjdl时间了四大皆空傅雷家书建档立卡解放路卡")
        msg.direction  = .incoming
        msg.textMessage = text
        return msg
    }
    static func testOne() -> HUIMessage{
        var msg = HUIMessage()
        let text = HUITextMessage.init(content: "精力时间打卡时间来看待加了看似简单快乐就是雷锋精神链接发拉开距离可视对讲来开发时间了四大皆空傅雷家书建档立卡解放路卡")
        msg.direction  = .outgoing
        msg.textMessage = text
        return msg
    }
    static func tests()->[HUIMessage]{
        return [test(),testOne()]
    }
}
struct HUITextMessage{
    let content:String
}
class HUIImageMessage{
    var url:String
    init(url:String){
        self.url = url
    }
}

struct HUISessionCellData:Identifiable,Hashable {
    let id = UUID()
    var time:String! = "昨天"
    var faceUrl:String?

   /**  会话草稿箱
    */
   var draftText:String?
   /**
    *  标题
    */
   var title:String! = "测试标题"
   /**
    *  会话消息概览（下标题）
    *  概览负责显示对应会话最新一条消息的内容/类型。
    *  当最新的消息为文本消息/系统消息时，概览的内容为消息的文本内容。
    *  当最新的消息为多媒体消息时，概览的内容为对应的多媒体形式，如：“动画表情” / “[文件]” / “[语音]” / “[图片]” / “[视频]” 等。
    *  若当前会话有草稿时，概览内容为：“[草稿]XXXXX”，XXXXX为草稿内容。
    */
   var subTitle:String! = "你好，去钓鱼多久了时间啊链接发上来开附件的大匠科技类是否"
   var sessionId:String!

    var isPinned = false
    var isOfflineMsg = false
    var timestamp:Int64 = 0
    var unreadCount = 0
}
enum HUIMsgDirection {
    case incoming   //消息接收
    case outgoing   //消息发送
}
struct HUIMessage:Identifiable{
    /// 消息id
    let id = UUID().uuidString
    var uid:String?
    /// 消息发送者
    var senderId: String!
    //消息目标的id
    var targetId:String!
    /// 消息发送者
    var sender:HIMUser!
    /// 消息时间
    var timestamp :Date!
    /// 消息内容
    var textMessage:HUITextMessage?
    var elemType:Pb_ElemType!
    var imageMessage:HUIImageMessage?
    //消息方向
    var direction:HUIMsgDirection!
    
}
