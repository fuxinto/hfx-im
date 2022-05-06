//
//  HIMSessionManager.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/5/6.
//

import Foundation
extension HIMSessionListener{
    func onSyncServerStart(){}
    func onSyncServerFinish(){}
    func onSyncServerFailed(){}
    func onNew(sessionList:[HIMSession]){}
    func onSessionChanged(sessionList:[HIMSession]){}
    func onTotalUnreadMessageCountChanged(totalUnreadCount:UInt64){}
}
protocol HIMSessionListener:NSObjectProtocol{
    /**
     * 同步服务器会话开始，SDK 会在登录成功或者断网重连后自动同步服务器会话，您可以监听这个事件做一些 UI 进度展示操作。
     */
    func onSyncServerStart()
    /**
     * 同步服务器会话完成，如果会话有变更，会通过 onNewConversation | onConversationChanged 回调告知客户
     */
    func onSyncServerFinish()
    /**
     * 同步服务器会话失败
     */
    func onSyncServerFailed()
    /**
     * 有新的会话（比如收到一个新同事发来的单聊消息、或者被拉入了一个新的群组中），可以根据会话的 lastMessage -> timestamp 重新对会话列表做排序。
     */
    func onNew(sessionList:[HIMSession])
    
    /**
     * 某些会话的关键信息发生变化（未读计数发生变化、最后一条消息被更新等等），可以根据会话的 lastMessage -> timestamp 重新对会话列表做排序。
     */
    func onSessionChanged(sessionList:[HIMSession])
    /**
     * 会话未读总数变更通知（5.3.425 及以上版本支持）
     * @note
     *  - 未读总数会减去设置为免打扰的会话的未读数，即消息接收选项设置为 V2TIMMessage.V2TIM_NOT_RECEIVE_MESSAGE 或 V2TIMMessage.V2TIM_RECEIVE_NOT_NOTIFY_MESSAGE 的会话。
     */
    func onTotalUnreadMessageCountChanged(totalUnreadCount:UInt64)
}

class HIMSessionManager {

    weak var listener:HIMSessionListener?
//    func addSessionListener(_ listener:HIMSessionListener) {
//        listeners.append(listener)
//    }
//    
//    func removeSessionListener(_ listener:HIMSessionListener) {
//        listeners = listeners.filter { $0 != listener }
//    }
    func getSessionList(offset: Int, count: Int,succ:([HIMSession],Int,Bool)-> Void,fail:HIMFail) {
        let request = HIMSession.fetchRequest()
        request.fetchOffset = offset
        request.fetchLimit = count
        request.sortDescriptors = [NSSortDescriptor.init(key: "timestamp", ascending: false)]
        do {
            let list =  try PersistenceController.shared.privateContext.fetch(request)
           
            for session in list {
                session.lastMessage = HIMMessage.getLast(sessionId: session.sessionId!)
            }
            succ(list, count+offset, list.count>=count)
        } catch let error {
            FXLog("getLastMsgTimestamp(),error:\(error.localizedDescription)")
            fail(2001, "查询失败")
        }
    }
    
}
