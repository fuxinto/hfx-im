////
////  FXConversationManager.swift
////  FXRecipes
////
////  Created by hfx on 2021/9/7.
////  Copyright © 2021 黄福鑫. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//protocol HIMConversationDelegate:NSObjectProtocol{
//    //有新的会话
//    func onNewConversation(conversationList:[FXIMConversation])
//    //会话有更新
//    func onConversationChanged(conversationList:[FXIMConversation])
//}
//
//class FXIMConversationManager {
//    weak var delegate:HIMConversationDelegate?
//    //更新未读数
//    func update(msg:FXIMMessage) {
//        if let conv = FXIMSDK.shared.convList.first(where: { conv in
//            return conv.conversationId == msg.talker
//        }) {
//            conv.unreadCount = 0
//            FXIMCoreDataManager.shared.saveContext()
//            self.delegate?.onConversationChanged(conversationList: [conv])
//        }
//    }
//    func received(msg:FXIMMessage) {
//        let talker = FXIMSDK.shared.loginManager.userId == msg.receiverId ? msg.senderId : msg.receiverId
////       //判断本地是否有当前消息的会话
//        var conv : FXIMConversation
//        // 更新 会话列表，如果会话列表有新增的会话，就删除原来的，就新增到最前面
//        if let index = FXIMSDK.shared.convList.firstIndex(where: { localConv in
//            return localConv.conversationId == talker
//        }) {
//            conv = FXIMSDK.shared.convList[index]
//            FXIMSDK.shared.convList.remove(at: index)
//            if msg.senderId != FXIMSDK.shared.loginManager.userId {
//                conv.unreadCount += 1
//            }
//        }else{
//            //没有会话就新建一个
//            conv = FXIMConversation.fx.create()
//            conv.conversationId = talker
//        }
//        conv.lastMessage = msg
//        conv.time = msg.time
//        FXIMSDK.shared.convList.insert(conv, at: 0)
//        FXIMCoreDataManager.shared.saveContext()
//
//        self.delegate?.onConversationChanged(conversationList: [conv])
//    }
//
//
//    /**
//     *  1.2 获取会话列表
//     *
//     *  - 一个会话对应一个聊天窗口，比如跟一个好友的 1v1 聊天，或者一个聊天群，都是一个会话。
//     *  - 由于历史的会话数量可能很多，所以该接口希望您采用分页查询的方式进行调用，每次分页拉取的个数建议为 100 个。
//     *  - 该接口拉取的是本地缓存的会话，如果服务器会话有更新，SDK 内部会自动同步，然后在 V2TIMConversationListener 告知客户。
//     *  - 该接口获取的会话默认已经按照会话 lastMessage -> timestamp 做了排序，timestamp 越大，会话越靠前。
//     *  - 如果会话全部拉取完毕，成功回调里面的 isFinished 字段值为 YES。
//     *
//     *  @param nextSeq 分页拉取游标，第一次默认取传 0，后续分页拉传上一次分页拉取回调里的 nextSeq
//     *  @param count  分页拉取的个数，一次分页拉取不宜太多，会影响拉取的速度，建议每次拉取 100 个会话
//     */
//     func getConversationList(offset:Int,count:Int = 100,succ:@escaping FXIMConversationResultSucc,fail:@escaping FXIMFail) {
//        FXIMConversation.getConversationList(offset: offset, succ: succ, fail: fail)
//    }
//}
//
